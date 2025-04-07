Return-Path: <linux-fsdevel+bounces-45874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D44AA7E0A3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 16:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D62371744BA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 14:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088651C68BE;
	Mon,  7 Apr 2025 14:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HnXVBOJT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DE418309C;
	Mon,  7 Apr 2025 14:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744034705; cv=none; b=hdGI0VgyFCraRY8RI0UU+RWgDHeNihHOp7ZXRtDWsWaUmkojIFHX2Bnzm4pyKd4XkqWMq5+xdhmdvMeVDQ2oGZcZzoVvKozfzB0HU5EtZlwlQM5IAeDBSdSNCdM6piuvXQz+rWJzqT6/I02KomMX3PhvrnuDH8n1zwHH5PSjYDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744034705; c=relaxed/simple;
	bh=UrskWe3k68R3fO9XFFHhGHLVqM5/0h1myV4hLXPpFKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tr2vgxc5hCmsxN3O6EBN9ZCgUUHkia1WqP3l9pcy9NWcx4MIFbDxzX+FBsZ5pvmu0KmxG+qCrfWQj39vlIsN8vo4I7e8ZT//wESYlSdcbbfmgQdFz8IPCbAq/bhl+t/lQQdEACSsyAXngdR/l/om/JRFUtmFzUUI2PwWatP6uwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=HnXVBOJT; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744034704; x=1775570704;
  h=message-id:date:mime-version:reply-to:subject:to:
   references:from:in-reply-to:content-transfer-encoding;
  bh=uq2h5sky/CvUJaMJBluVu3u5R/GWwG3pKY9q88OMKG4=;
  b=HnXVBOJTmzFdJTJEotLuwHr5szJcwumNdyPrLBcq3OkfQtjIkoRGHzGW
   spIA7HmeDHMyKlSmT77H1eEUOVSUC3pHeGBzaapENLFZciwFPrvtgGjfk
   pAWQkrgDsmue6xC9CuXTuoF66g3bJq5DdCGRLCqxqQmROyvyhpjtb/gdP
   A=;
X-IronPort-AV: E=Sophos;i="6.15,194,1739836800"; 
   d="scan'208";a="8234197"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 14:04:55 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.43.254:57703]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.10.242:2525] with esmtp (Farcaster)
 id 4b69fdfb-9238-4c3e-a5a7-9259ba1d2b28; Mon, 7 Apr 2025 14:04:54 +0000 (UTC)
X-Farcaster-Flow-ID: 4b69fdfb-9238-4c3e-a5a7-9259ba1d2b28
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 7 Apr 2025 14:04:54 +0000
Received: from [192.168.3.31] (10.106.83.24) by EX19D022EUC002.ant.amazon.com
 (10.252.51.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14; Mon, 7 Apr 2025
 14:04:52 +0000
Message-ID: <ba93b9c1-cb2b-442f-a4c4-b5530e94f88a@amazon.com>
Date: Mon, 7 Apr 2025 15:04:51 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v3 0/6] KVM: guest_memfd: support for uffd minor
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Ackerley Tng
	<ackerleytng@google.com>, Vishal Annapurve <vannapurve@google.com>, "Fuad
 Tabba" <tabba@google.com>, <akpm@linux-foundation.org>,
	<pbonzini@redhat.com>, <shuah@kernel.org>, <viro@zeniv.linux.org.uk>,
	<brauner@kernel.org>, <muchun.song@linux.dev>, <hughd@google.com>,
	<kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>, <jack@suse.cz>,
	<lorenzo.stoakes@oracle.com>, <jannh@google.com>, <ryan.roberts@arm.com>,
	<david@redhat.com>, <jthoughton@google.com>, <peterx@redhat.com>,
	<graf@amazon.de>, <jgowans@amazon.com>, <roypat@amazon.co.uk>,
	<derekmn@amazon.com>, <nsaenz@amazon.es>, <xmarcalx@amazon.com>
References: <20250404154352.23078-1-kalyazin@amazon.com>
 <2iggdfimgfke5saxs74zmfrswgrxmmsyxzphq4mdfpj54wu4pl@5uiia4pzkxem>
 <e8abe599-f48f-4203-8c60-9ee776aa4a24@amazon.com>
 <63j2cdjh6oxzb5ehtetiaolobp6zzev7emgqvvfkf5tuwlnspx@7h5u4nrqwvsc>
Content-Language: en-US
From: Nikita Kalyazin <kalyazin@amazon.com>
Autocrypt: addr=kalyazin@amazon.com; keydata=
 xjMEY+ZIvRYJKwYBBAHaRw8BAQdA9FwYskD/5BFmiiTgktstviS9svHeszG2JfIkUqjxf+/N
 JU5pa2l0YSBLYWx5YXppbiA8a2FseWF6aW5AYW1hem9uLmNvbT7CjwQTFggANxYhBGhhGDEy
 BjLQwD9FsK+SyiCpmmTzBQJnrNfABQkFps9DAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQr5LK
 IKmaZPOpfgD/exazh4C2Z8fNEz54YLJ6tuFEgQrVQPX6nQ/PfQi2+dwBAMGTpZcj9Z9NvSe1
 CmmKYnYjhzGxzjBs8itSUvWIcMsFzjgEY+ZIvRIKKwYBBAGXVQEFAQEHQCqd7/nb2tb36vZt
 ubg1iBLCSDctMlKHsQTp7wCnEc4RAwEIB8J+BBgWCAAmFiEEaGEYMTIGMtDAP0Wwr5LKIKma
 ZPMFAmes18AFCQWmz0MCGwwACgkQr5LKIKmaZPNTlQEA+q+rGFn7273rOAg+rxPty0M8lJbT
 i2kGo8RmPPLu650A/1kWgz1AnenQUYzTAFnZrKSsXAw5WoHaDLBz9kiO5pAK
In-Reply-To: <63j2cdjh6oxzb5ehtetiaolobp6zzev7emgqvvfkf5tuwlnspx@7h5u4nrqwvsc>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D008EUA002.ant.amazon.com (10.252.50.179) To
 EX19D022EUC002.ant.amazon.com (10.252.51.137)



On 07/04/2025 14:40, Liam R. Howlett wrote:
> * Nikita Kalyazin <kalyazin@amazon.com> [250407 07:04]:
>>
>>
>> On 04/04/2025 18:12, Liam R. Howlett wrote:
>>> +To authors of v7 series referenced in [1]
>>>
>>> * Nikita Kalyazin <kalyazin@amazon.com> [250404 11:44]:
>>>> This series is built on top of the Fuad's v7 "mapping guest_memfd backed
>>>> memory at the host" [1].
>>>
>>> I didn't see their addresses in the to/cc, so I added them to my
>>> response as I reference the v7 patch set below.
>>
>> Hi Liam,
>>
>> Thanks for the feedback and for extending the list.
>>
>>>
>>>>
>>>> With James's KVM userfault [2], it is possible to handle stage-2 faults
>>>> in guest_memfd in userspace.  However, KVM itself also triggers faults
>>>> in guest_memfd in some cases, for example: PV interfaces like kvmclock,
>>>> PV EOI and page table walking code when fetching the MMIO instruction on
>>>> x86.  It was agreed in the guest_memfd upstream call on 23 Jan 2025 [3]
>>>> that KVM would be accessing those pages via userspace page tables.
>>>
>>> Thanks for being open about the technical call, but it would be better
>>> to capture the reasons and not the call date.  I explain why in the
>>> linking section as well.
>>
>> Thanks for bringing that up.  The document mostly contains the decision
>> itself.  The main alternative considered previously was a temporary
>> reintroduction of the pages to the direct map whenever a KVM-internal access
>> is required.  It was coming with a significant complexity of guaranteeing
>> correctness in all cases [1].  Since the memslot structure already contains
>> a guest memory pointer supplied by the userspace, KVM can use it directly
>> when in the VMM or vCPU context.  I will add this in the cover for the next
>> version.
> 
> Thank you.
> 
>>
>> [1] https://lore.kernel.org/kvm/20240709132041.3625501-1-roypat@amazon.co.uk/T/#m4f367c52bbad0f0ba7fb07ca347c7b37258a73e5
>>
>>>
>>>> In
>>>> order for such faults to be handled in userspace, guest_memfd needs to
>>>> support userfaultfd.
>>>>
>>>> Changes since v2 [4]:
>>>>    - James: Fix sgp type when calling shmem_get_folio_gfp
>>>>    - James: Improved vm_ops->fault() error handling
>>>>    - James: Add and make use of the can_userfault() VMA operation
>>>>    - James: Add UFFD_FEATURE_MINOR_GUEST_MEMFD feature flag
>>>>    - James: Fix typos and add more checks in the test
>>>>
>>>> Nikita
>>>
>>> Please slow down...
>>>
>>> This patch is at v3, the v7 patch that you are building off has lockdep
>>> issues [1] reported by one of the authors, and (sorry for sounding harsh
>>> about the v7 of that patch) the cover letter reads a bit more like an
>>> RFC than a set ready to go into linux-mm.
>>
>> AFAIK the lockdep issue was reported on a v7 of a different change.
>> I'm basing my series on [2] ("KVM: Mapping guest_memfd backed memory at the
>> host for software protected VMs"), while the issue was reported on [2]
>> ("KVM: Restricted mapping of guest_memfd at the host and arm64 support"),
>> which is also built on top of [2].  Please correct me if I'm missing
>> something.
> 
> I think you messed up the numbering in your statement above.

I did, in an attempt to make it "even more clear" :) Sorry about that, 
glad you got the intention.

> 
> I believe you are making the point that I messed up which patches depend
> on what and your code does not depend on faulty locking, which appears
> to be the case.
> 
> There are a few issues with the required patch set?

There are indeed, but not in the part this series depends on, as far as 
I can see.

> 
>>
>> The key feature that is required by my series is the ability to mmap
>> guest_memfd when the VM type allows.  My understanding is no-one is opposed
>> to that as of now, that's why I assumed it's safe to build on top of that.
>>
>> [2] https://lore.kernel.org/kvm/20250318161823.4005529-1-tabba@google.com/T/
>> [3] https://lore.kernel.org/all/diqz1puanquh.fsf@ackerleytng-ctop.c.googlers.com/T/
> 
> All of this is extremely confusing because the onus of figuring out what
> the final code will look like is put on the reviewer.  As it is, we have
> issues with people not doing enough review of the code (due to limited
> time).  One way to get reviews is to make the barrier of entry as low as
> possible.
> 
> I spent Friday going down a rabbit hole of patches referring to each
> other as dependencies and I gave up.  It looks like I mistook one set of
> patches as required vs them requiring the same in-flight ones as your
> patches.
> 
> I am struggling to see how we can adequately support all of you given
> the way the patches are sent out in batches with dependencies - it is
> just too time consuming to sort out.

I'm happy to do whatever I can to make the review easier.  I suppose the 
extreme case is to wait for the dependencies to get accepted, 
effectively serialising submissions, but that slows the process down 
significantly.  For example, I received very good feedback on v1 and v2 
of this series and was able to address it instead of waiting for the 
dependency.  Would including the required patches directly in the series 
help?  My only concern is in that case the same patch will be submitted 
multiple times (as a part of every depending series), but if it's 
better, I'll be doing that instead.

> 
> Thank you,
> Liam
> 


