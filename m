Return-Path: <linux-fsdevel+bounces-38905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 235E8A09B70
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 20:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AD613A4C4A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 19:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FE6224AE0;
	Fri, 10 Jan 2025 18:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gUcds19a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54E320764A;
	Fri, 10 Jan 2025 18:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736535255; cv=none; b=VUJ/NozgnvvZqPE43J544XbzByafdaMiI2neI74xbj52jcsMfrV4Gxg4sptEaqXfTuGN2EOsUThatM5n5QRO3That/Tz8gAzyB3Rnw2Vs7zZNZ4nwApXLmlXwwVKs9z+hTP3Z4PSdyGPBEzMz9zJkSrcLWfkC4c7zjzw8bERhlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736535255; c=relaxed/simple;
	bh=N67Au3zI8gSuIxYQ9HZyBG+m19KuGbzYRH6GokXtSEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dxGBeIjNbWOEDW6RnHoIGgho7esES+FwzcAp5IuXi/qUPjCbGyzjySyfkox+kyIN/0z8q61pwhrCC7Fmnf0bqUPYyC+rID7nCPQg3NWc2XM8iJEKXwaLI7vFzAFU0C4jVF5dtpHGPOJhmiO9IqZgJvUlPn2pWqorhjHqf7NWt6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=gUcds19a; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736535254; x=1768071254;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=dVDd8Owu5mmhfXq9kotQZKYGFY24PHmq4HgS4SvakZc=;
  b=gUcds19avaxUCstr+CyS1qGDEVfX5eIYn1FsMRpvSnk3NIL+7QaQVVO+
   WC3At/RfLGwocCOwNi0BCWwDBvK+RE0Wfj66wNSe55a18EsfHmq+vl/5/
   BjTk8+u4TdMQ4M0zo6WOIawLA5woqMwze3OIGClshsNsyBvtDoNXPs8BL
   k=;
X-IronPort-AV: E=Sophos;i="6.12,305,1728950400"; 
   d="scan'208";a="13453976"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 18:54:12 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.43.254:2623]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.45.180:2525] with esmtp (Farcaster)
 id b928f9af-217a-405f-8ef6-6ae3379b2b81; Fri, 10 Jan 2025 18:54:11 +0000 (UTC)
X-Farcaster-Flow-ID: b928f9af-217a-405f-8ef6-6ae3379b2b81
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 10 Jan 2025 18:54:10 +0000
Received: from [192.168.12.16] (10.106.82.30) by EX19D022EUC002.ant.amazon.com
 (10.252.51.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39; Fri, 10 Jan 2025
 18:54:09 +0000
Message-ID: <bda9f9a8-1e5a-454e-8506-4e31e6b4c152@amazon.com>
Date: Fri, 10 Jan 2025 18:54:03 +0000
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
In-Reply-To: <5608af05-0b7a-4e11-b381-8b57b701e316@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D002EUC003.ant.amazon.com (10.252.51.218) To
 EX19D022EUC002.ant.amazon.com (10.252.51.137)

On 10/01/2025 17:01, David Hildenbrand wrote:
> On 10.01.25 16:46, Nikita Kalyazin wrote:
>> Based on David's suggestion for speeding up guest_memfd memory
>> population [1] made at the guest_memfd upstream call on 5 Dec 2024 [2],
>> this adds `filemap_grab_folios` that grabs multiple folios at a time.
>>
> 
> Hi,

Hi :)

> 
>> Motivation
>>
>> When profiling guest_memfd population and comparing the results with
>> population of anonymous memory via UFFDIO_COPY, I observed that the
>> former was up to 20% slower, mainly due to adding newly allocated pages
>> to the pagecache.  As far as I can see, the two main contributors to it
>> are pagecache locking and tree traversals needed for every folio.  The
>> RFC attempts to partially mitigate those by adding multiple folios at a
>> time to the pagecache.
>>
>> Testing
>>
>> With the change applied, I was able to observe a 10.3% (708 to 635 ms)
>> speedup in a selftest that populated 3GiB guest_memfd and a 9.5% (990 to
>> 904 ms) speedup when restoring a 3GiB guest_memfd VM snapshot using a
>> custom Firecracker version, both on Intel Ice Lake.
> 
> Does that mean that it's still 10% slower (based on the 20% above), or
> were the 20% from a different micro-benchmark?

Yes, it is still slower:
  - isolated/selftest: 2.3%
  - Firecracker setup: 8.9%

Not sure why the values are so different though.  I'll try to find an 
explanation.

>>
>> Limitations
>>
>> While `filemap_grab_folios` handles THP/large folios internally and
>> deals with reclaim artifacts in the pagecache (shadows), for simplicity
>> reasons, the RFC does not support those as it demonstrates the
>> optimisation applied to guest_memfd, which only uses small folios and
>> does not support reclaim at the moment.
> 
> It might be worth pointing out that, while support for larger folios is
> in the works, there will be scenarios where small folios are unavoidable
> in the future (mixture of shared and private memory).
> 
> How hard would it be to just naturally support large folios as well?

I don't think it's going to be impossible.  It's just one more dimension 
that needs to be handled.  `__filemap_add_folio` logic is already rather 
complex, and processing multiple folios while also splitting when 
necessary correctly looks substantially convoluted to me.  So my idea 
was to discuss/validate the multi-folio approach first before rolling 
the sleeves up.

> We do have memfd_pin_folios() that can deal with that and provides a
> slightly similar interface (struct folio **folios).
> 
> For reference, the interface is:
> 
> long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
>                       struct folio **folios, unsigned int max_folios,
>                       pgoff_t *offset)
> 
> Maybe what you propose could even be used to further improve
> memfd_pin_folios() internally? However, it must do this FOLL_PIN thingy,
> so it must process each and every folio it processed.

Thanks for the pointer.  Yeah, I see what you mean.  I guess, it can 
potentially allocate/add folios in a batch and then pin them?  Although 
swap/readahead logic may make it more difficult to implement.

> -- 
> Cheers,
> 
> David / dhildenb 


