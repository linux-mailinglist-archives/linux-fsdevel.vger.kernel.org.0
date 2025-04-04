Return-Path: <linux-fsdevel+bounces-45783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A268A7C1E9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 18:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 163E03AABB5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 16:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136D321171C;
	Fri,  4 Apr 2025 16:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="fZGJyujM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7716B1F181F;
	Fri,  4 Apr 2025 16:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743785832; cv=none; b=HLgqO0w27OXKKRotEpyrT7s7t0XYN0qD+h+MECLBohwdUcQuuWhiBx0hv5HtjqJKkQZkNxvsqzO9z+bohWt6avbWhEvXrSKV2T3jH8ki/FfuLDSQ+Qy08AYnCVKCM49HlRs1ly9XYqjkuf/+Q2Vc1VWpPV3esmEyFrHx7J775Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743785832; c=relaxed/simple;
	bh=BLiYuymZw8Lyw8StYwch70EbD2w6gZ46m2fiklLEE/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=vC5QRtBRJ4CWdmRCcGW0hyyuPPzxp5nmTGjE64aKHAEf+wR6FL6+j+ETe19i83CMIzIMm+pdhVREiUaTMeK5lFmIKQtnB2mTG9shk3aydMS7mfx8BB8XsUtMIeOHfGlFgu3YvIvqXAi6lUPP8x+YGtoZj0g4c9VJIkNNDrAN1sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=fZGJyujM; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743785830; x=1775321830;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=9rUrMyu/a+RU240va8IIR8/YaSk2+sCGn0wmfW0D9/A=;
  b=fZGJyujMkk4R6jMNUiB52NaNqo6aWGym3Hp6x+Ttcz8UnUbt8Fxnk3QN
   DjFrs1RnfQsf5FJ8DJkl2v1Jwo8hPNuQRcltSlqFsbWaqD3D4r6I+WY8K
   UcfNSTL/fGbbuelXugtoALjSxOGryIJSAY/N/zIghpkXbRJXBvkMr+2UJ
   4=;
X-IronPort-AV: E=Sophos;i="6.15,188,1739836800"; 
   d="scan'208";a="480444447"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 16:57:06 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.10.100:35113]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.46.175:2525] with esmtp (Farcaster)
 id 249756d1-c399-4b2b-a390-7506b932c09d; Fri, 4 Apr 2025 16:57:04 +0000 (UTC)
X-Farcaster-Flow-ID: 249756d1-c399-4b2b-a390-7506b932c09d
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 4 Apr 2025 16:57:04 +0000
Received: from [192.168.0.47] (10.106.83.30) by EX19D022EUC002.ant.amazon.com
 (10.252.51.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14; Fri, 4 Apr 2025
 16:57:03 +0000
Message-ID: <7b8d9aa6-99ff-4986-bd16-664de63ecb58@amazon.com>
Date: Fri, 4 Apr 2025 17:56:58 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v3 0/6] KVM: guest_memfd: support for uffd minor
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
CC: <akpm@linux-foundation.org>, <pbonzini@redhat.com>, <shuah@kernel.org>,
	<viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <muchun.song@linux.dev>,
	<hughd@google.com>, <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>, <jack@suse.cz>, <Liam.Howlett@oracle.com>,
	<jannh@google.com>, <ryan.roberts@arm.com>, <david@redhat.com>,
	<jthoughton@google.com>, <peterx@redhat.com>, <graf@amazon.de>,
	<jgowans@amazon.com>, <roypat@amazon.co.uk>, <derekmn@amazon.com>,
	<nsaenz@amazon.es>, <xmarcalx@amazon.com>
References: <20250404154352.23078-1-kalyazin@amazon.com>
 <dc4c72a2-41c1-4548-a6ee-5a17895e4940@lucifer.local>
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
In-Reply-To: <dc4c72a2-41c1-4548-a6ee-5a17895e4940@lucifer.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D005EUA002.ant.amazon.com (10.252.50.11) To
 EX19D022EUC002.ant.amazon.com (10.252.51.137)



On 04/04/2025 17:33, Lorenzo Stoakes wrote:
> On Fri, Apr 04, 2025 at 03:43:46PM +0000, Nikita Kalyazin wrote:
>> This series is built on top of the Fuad's v7 "mapping guest_memfd backed
>> memory at the host" [1].
> 
> Hm if this is based on an unmerged series this seems quite speculative and
> should maybe be an RFC? I mean that series at least still seems quite under
> discussion/experiencing issues?
> 
> Maybe worth RFC'ing until that one settles down first to avoid complexity
> in review/application to tree?

Hi,

I dropped the RFC tag because I saw similar examples before, but I'm 
happy to bring it back next time if the dependency is not merged until then.

> 
> Thanks!

Thanks!

> 
>>
>> With James's KVM userfault [2], it is possible to handle stage-2 faults
>> in guest_memfd in userspace.  However, KVM itself also triggers faults
>> in guest_memfd in some cases, for example: PV interfaces like kvmclock,
>> PV EOI and page table walking code when fetching the MMIO instruction on
>> x86.  It was agreed in the guest_memfd upstream call on 23 Jan 2025 [3]
>> that KVM would be accessing those pages via userspace page tables.  In
>> order for such faults to be handled in userspace, guest_memfd needs to
>> support userfaultfd.
>>
>> Changes since v2 [4]:
>>   - James: Fix sgp type when calling shmem_get_folio_gfp
>>   - James: Improved vm_ops->fault() error handling
>>   - James: Add and make use of the can_userfault() VMA operation
>>   - James: Add UFFD_FEATURE_MINOR_GUEST_MEMFD feature flag
>>   - James: Fix typos and add more checks in the test
>>
>> Nikita
>>
>> [1] https://lore.kernel.org/kvm/20250318161823.4005529-1-tabba@google.com/T/
>> [2] https://lore.kernel.org/kvm/20250109204929.1106563-1-jthoughton@google.com/T/
>> [3] https://docs.google.com/document/d/1M6766BzdY1Lhk7LiR5IqVR8B8mG3cr-cxTxOrAosPOk/edit?tab=t.0#heading=h.w1126rgli5e3
>> [4] https://lore.kernel.org/kvm/20250402160721.97596-1-kalyazin@amazon.com/T/
>>
>> Nikita Kalyazin (6):
>>    mm: userfaultfd: generic continue for non hugetlbfs
>>    mm: provide can_userfault vma operation
>>    mm: userfaultfd: use can_userfault vma operation
>>    KVM: guest_memfd: add support for userfaultfd minor
>>    mm: userfaultfd: add UFFD_FEATURE_MINOR_GUEST_MEMFD
>>    KVM: selftests: test userfaultfd minor for guest_memfd
>>
>>   fs/userfaultfd.c                              |  3 +-
>>   include/linux/mm.h                            |  5 +
>>   include/linux/mm_types.h                      |  4 +
>>   include/linux/userfaultfd_k.h                 | 10 +-
>>   include/uapi/linux/userfaultfd.h              |  8 +-
>>   mm/hugetlb.c                                  |  9 +-
>>   mm/shmem.c                                    | 17 +++-
>>   mm/userfaultfd.c                              | 47 ++++++---
>>   .../testing/selftests/kvm/guest_memfd_test.c  | 99 +++++++++++++++++++
>>   virt/kvm/guest_memfd.c                        | 10 ++
>>   10 files changed, 188 insertions(+), 24 deletions(-)
>>
>>
>> base-commit: 3cc51efc17a2c41a480eed36b31c1773936717e0
>> --
>> 2.47.1
>>


