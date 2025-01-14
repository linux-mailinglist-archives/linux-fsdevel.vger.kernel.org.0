Return-Path: <linux-fsdevel+bounces-39157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B4EA10BD2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 17:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E25B1886F22
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 16:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D0A1CF2B7;
	Tue, 14 Jan 2025 16:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vC5Tc41L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B551CC177;
	Tue, 14 Jan 2025 16:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736870877; cv=none; b=Thr/SW93TSW+25gvNbXW56bfo7hFnEWDJrPcP0+CwIJJ5YJPZTwJLu/W/H4f+m+c+hSwmEnK4kPtMNFGkJ46vUKJ8ZPCKSec1/yeGP/nyIV4vTALzh/zVjUC5/SL15Vj3OLyZ1Sl6O1VLGAupTs+dfH0IVGqQLaLhzJOHaHhC0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736870877; c=relaxed/simple;
	bh=VWuKUxBFkL9BcGV2ikjvdf18EaesgN5ZxS1ROrhkIhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=D8ZtYAOpLBZZM6ZwTDYJOq1+VUzXDIu1m0XkYdeqlopUK9ts/7cVXxtx2uQumpYh1weN8LNeZ833kX2J4CZDEXcLjNlZgX2m3F+nS/7yJeI+8nWqv9MGUUXwvZND4IzDNi1TjFoaxdKxcWHfd8miZwHezK4kkihspX/2B8E7Tgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=vC5Tc41L; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736870876; x=1768406876;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=X7ZylsU2EhTKBUzFmMhtT8tsRSiHQINi1OiMWtiHxJI=;
  b=vC5Tc41LwRbUHUHcuEpg69k4QaBZtaGRMQhzLX4cA2QfCCm3/ywY4g81
   CoyPFBV+Fwfj3MBWYTgubpdWvWtPlME6mNuSwKOBZTdBAZVbYzH5JDOJP
   9NC/rO3KvEnA+Fpg1hMFNEfBrdRSQxgnlAY8uFhSc5vnDR3uilHvO9DTq
   0=;
X-IronPort-AV: E=Sophos;i="6.12,314,1728950400"; 
   d="scan'208";a="790990836"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 16:07:50 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.17.79:1598]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.13.19:2525] with esmtp (Farcaster)
 id 13a91ab9-83c4-4235-b79e-b137bc62dd5b; Tue, 14 Jan 2025 16:07:48 +0000 (UTC)
X-Farcaster-Flow-ID: 13a91ab9-83c4-4235-b79e-b137bc62dd5b
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 14 Jan 2025 16:07:47 +0000
Received: from [192.168.8.40] (10.106.82.12) by EX19D022EUC002.ant.amazon.com
 (10.252.51.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39; Tue, 14 Jan 2025
 16:07:46 +0000
Message-ID: <9a188baa-034b-4dd5-b90e-7182f1fbaec6@amazon.com>
Date: Tue, 14 Jan 2025 16:07:45 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [RFC PATCH 0/2] mm: filemap: add filemap_grab_folios
To: David Hildenbrand <david@redhat.com>, <willy@infradead.org>,
	<pbonzini@redhat.com>, <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>
CC: <michael.day@amd.com>, <jthoughton@google.com>, <michael.roth@amd.com>,
	<ackerleytng@google.com>, <graf@amazon.de>, <jgowans@amazon.com>,
	<roypat@amazon.co.uk>, <derekmn@amazon.com>, <nsaenz@amazon.es>,
	<xmarcalx@amazon.com>
References: <20250110154659.95464-1-kalyazin@amazon.com>
 <5608af05-0b7a-4e11-b381-8b57b701e316@redhat.com>
 <bda9f9a8-1e5a-454e-8506-4e31e6b4c152@amazon.com>
 <5c62bdbb-7a4e-4178-8c03-e84491d8d150@redhat.com>
Content-Language: en-US
From: Nikita Kalyazin <kalyazin@amazon.com>
Autocrypt: addr=kalyazin@amazon.com; keydata=
 xjMEY+ZIvRYJKwYBBAHaRw8BAQdA9FwYskD/5BFmiiTgktstviS9svHeszG2JfIkUqjxf+/N
 JU5pa2l0YSBLYWx5YXppbiA8a2FseWF6aW5AYW1hem9uLmNvbT7CjwQTFggANxYhBGhhGDEy
 BjLQwD9FsK+SyiCpmmTzBQJj5ki9BQkDwmcAAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQr5LK
 IKmaZPOR1wD/UTcn4GbLC39QIwJuWXW0DeLoikxFBYkbhYyZ5CbtrtAA/2/rnR/zKZmyXqJ6
 ULlSE8eWA3ywAIOH8jIETF2fCaUCzjgEY+ZIvRIKKwYBBAGXVQEFAQEHQCqd7/nb2tb36vZt
 ubg1iBLCSDctMlKHsQTp7wCnEc4RAwEIB8J+BBgWCAAmFiEEaGEYMTIGMtDAP0Wwr5LKIKma
 ZPMFAmPmSL0FCQPCZwACGwwACgkQr5LKIKmaZPNCxAEAxwnrmyqSC63nf6hoCFCfJYQapghC
 abLV0+PWemntlwEA/RYx8qCWD6zOEn4eYhQAucEwtg6h1PBbeGK94khVMooF
In-Reply-To: <5c62bdbb-7a4e-4178-8c03-e84491d8d150@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D012EUC002.ant.amazon.com (10.252.51.162) To
 EX19D022EUC002.ant.amazon.com (10.252.51.137)

On 13/01/2025 12:20, David Hildenbrand wrote:
> On 10.01.25 19:54, Nikita Kalyazin wrote:
>> On 10/01/2025 17:01, David Hildenbrand wrote:
>>> On 10.01.25 16:46, Nikita Kalyazin wrote:
>>>> Based on David's suggestion for speeding up guest_memfd memory
>>>> population [1] made at the guest_memfd upstream call on 5 Dec 2024 [2],
>>>> this adds `filemap_grab_folios` that grabs multiple folios at a time.
>>>>
>>>
>>> Hi,
>>
>> Hi :)
>>
>>>
>>>> Motivation
>>>>
>>>> When profiling guest_memfd population and comparing the results with
>>>> population of anonymous memory via UFFDIO_COPY, I observed that the
>>>> former was up to 20% slower, mainly due to adding newly allocated pages
>>>> to the pagecache.  As far as I can see, the two main contributors to it
>>>> are pagecache locking and tree traversals needed for every folio.  The
>>>> RFC attempts to partially mitigate those by adding multiple folios at a
>>>> time to the pagecache.
>>>>
>>>> Testing
>>>>
>>>> With the change applied, I was able to observe a 10.3% (708 to 635 ms)
>>>> speedup in a selftest that populated 3GiB guest_memfd and a 9.5% 
>>>> (990 to
>>>> 904 ms) speedup when restoring a 3GiB guest_memfd VM snapshot using a
>>>> custom Firecracker version, both on Intel Ice Lake.
>>>
>>> Does that mean that it's still 10% slower (based on the 20% above), or
>>> were the 20% from a different micro-benchmark?
>>
>> Yes, it is still slower:
>>    - isolated/selftest: 2.3%
>>    - Firecracker setup: 8.9%
>>
>> Not sure why the values are so different though.  I'll try to find an
>> explanation.
> 
> The 2.3% looks very promising.

It does.  I sorted out my Firecracker setup and saw a similar figure 
there, which made me more confident.

>>
>>>>
>>>> Limitations
>>>>
>>>> While `filemap_grab_folios` handles THP/large folios internally and
>>>> deals with reclaim artifacts in the pagecache (shadows), for simplicity
>>>> reasons, the RFC does not support those as it demonstrates the
>>>> optimisation applied to guest_memfd, which only uses small folios and
>>>> does not support reclaim at the moment.
>>>
>>> It might be worth pointing out that, while support for larger folios is
>>> in the works, there will be scenarios where small folios are unavoidable
>>> in the future (mixture of shared and private memory).
>>>
>>> How hard would it be to just naturally support large folios as well?
>>
>> I don't think it's going to be impossible.  It's just one more dimension
>> that needs to be handled.  `__filemap_add_folio` logic is already rather
>> complex, and processing multiple folios while also splitting when
>> necessary correctly looks substantially convoluted to me.  So my idea
>> was to discuss/validate the multi-folio approach first before rolling
>> the sleeves up.
> 
> We should likely try making this as generic as possible, meaning we'll
> support roughly what filemap_grab_folio() would have supported (e.g., 
> also large folios).
> 
> Now I find filemap_get_folios_contig() [thas is already used in memfd 
> code],
> and wonder if that could be reused/extended fairly easily.

Fair, I will see into how it could be made generic.

> -- 
> Cheers,
> 
> David / dhildenb
> 


