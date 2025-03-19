Return-Path: <linux-fsdevel+bounces-44412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA50A68636
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 08:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C41D16A2F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 07:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2FC2505B2;
	Wed, 19 Mar 2025 07:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="DqG01zv6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B9C24EF7F;
	Wed, 19 Mar 2025 07:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742370839; cv=none; b=Lg6sqvoScINW1kI9rKECYQ9gsBXUh/ArTwCH4NU/uIPFPmZlEJlCIN8dqVPzDaaw6vnXATzTVjJJ3+Z5uFqdEhZjA0ZF1yyg6Zmq3Zqlzm74Ey4Nbw9YCZkBR2RWLpC0UlVT6RX0tJ6+8eR7D/EvIHXxi1+c++qFZAQnYMghf4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742370839; c=relaxed/simple;
	bh=ky3jiM1bjOMzTVRWpEBEoFuEvp1kviCET1tz7ZVwE2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=p8sRDjXxkj5H37obxICefLjVocm67tUslQfkJU9E4m66fo/T/qiVAZsDROPRwgK1Xib8zjrb78p4Oqi+ZCZ73ZV1OtIFnUaNHon6XPgQwJawgSc7/Uca9hfi41azEqJNHIAUEVAmM2Z2LhjnkGVhM9IbCuFKjFv3A7IipfNRQEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=DqG01zv6; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1742370839; x=1773906839;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jXl/8vzx6TOy29mjcSY/yyQLEaXHaFbsfFs77FD/cV4=;
  b=DqG01zv6efHOu5qF8LBUlJK8bGv0/di64ealz+ky2yRSAraysEpZX/O3
   l2+gmCRnUavBY4q3NPaHk+z5e6b1t40AyTs91I43cpNU/2YCpZPnWb2Mz
   i793CHBoh7ICQm8BJLz1StnIFOzDBVveVbW4sPRklXxGx2dAklUCRYBZj
   4=;
X-IronPort-AV: E=Sophos;i="6.14,259,1736812800"; 
   d="scan'208";a="472339262"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 07:53:51 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:10937]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.245:2525] with esmtp (Farcaster)
 id f1034041-96c5-4fa3-9e32-0aaec99408b2; Wed, 19 Mar 2025 07:53:50 +0000 (UTC)
X-Farcaster-Flow-ID: f1034041-96c5-4fa3-9e32-0aaec99408b2
Received: from EX19D020UWA001.ant.amazon.com (10.13.138.249) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 19 Mar 2025 07:53:50 +0000
Received: from EX19MTAUEC002.ant.amazon.com (10.252.135.146) by
 EX19D020UWA001.ant.amazon.com (10.13.138.249) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 19 Mar 2025 07:53:49 +0000
Received: from email-imr-corp-prod-iad-all-1a-f1af3bd3.us-east-1.amazon.com
 (10.43.8.6) by mail-relay.amazon.com (10.252.135.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Mar 2025 07:53:49 +0000
Received: from [127.0.0.1] (dev-dsk-roypat-1c-dbe2a224.eu-west-1.amazon.com [172.19.88.180])
	by email-imr-corp-prod-iad-all-1a-f1af3bd3.us-east-1.amazon.com (Postfix) with ESMTPS id 5C81F40881;
	Wed, 19 Mar 2025 07:53:45 +0000 (UTC)
Message-ID: <ad359b73-e50c-48e0-a5b5-4df9823fa289@amazon.co.uk>
Date: Wed, 19 Mar 2025 07:53:43 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/12] KVM: guest_memfd: Add flag to remove from direct
 map
To: David Hildenbrand <david@redhat.com>, <rppt@kernel.org>,
	<seanjc@google.com>
CC: <pbonzini@redhat.com>, <corbet@lwn.net>, <willy@infradead.org>,
	<akpm@linux-foundation.org>, <song@kernel.org>, <jolsa@kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <eddyz87@gmail.com>, <yonghong.song@linux.dev>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@fomichev.me>,
	<haoluo@google.com>, <Liam.Howlett@oracle.com>, <lorenzo.stoakes@oracle.com>,
	<vbabka@suse.cz>, <jannh@google.com>, <shuah@kernel.org>,
	<kvm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>, <bpf@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <tabba@google.com>, <jgowans@amazon.com>,
	<graf@amazon.com>, <kalyazin@amazon.com>, <xmarcalx@amazon.com>,
	<derekmn@amazon.com>, <jthoughton@google.com>, Elliot Berman
	<quic_eberman@quicinc.com>
References: <20250221160728.1584559-1-roypat@amazon.co.uk>
 <20250221160728.1584559-4-roypat@amazon.co.uk>
 <a3178c50-2e76-4743-8008-9a33bd0af93f@redhat.com>
 <8642de57-553a-47ec-81af-803280a360ec@amazon.co.uk>
 <bfe43591-66b6-4fb9-bf6c-df79ddeffb17@redhat.com>
 <7f38018b-dc89-4d79-a309-149557796121@amazon.co.uk>
 <9ffce724-23c9-4aa1-bc53-8292e1029991@redhat.com>
From: Patrick Roy <roypat@amazon.co.uk>
Content-Language: en-US
Autocrypt: addr=roypat@amazon.co.uk; keydata=
 xjMEY0UgYhYJKwYBBAHaRw8BAQdA7lj+ADr5b96qBcdINFVJSOg8RGtKthL5x77F2ABMh4PN
 NVBhdHJpY2sgUm95IChHaXRodWIga2V5IGFtYXpvbikgPHJveXBhdEBhbWF6b24uY28udWs+
 wpMEExYKADsWIQQ5DAcjaM+IvmZPLohVg4tqeAbEAgUCY0UgYgIbAwULCQgHAgIiAgYVCgkI
 CwIEFgIDAQIeBwIXgAAKCRBVg4tqeAbEAmQKAQC1jMl/KT9pQHEdALF7SA1iJ9tpA5ppl1J9
 AOIP7Nr9SwD/fvIWkq0QDnq69eK7HqW14CA7AToCF6NBqZ8r7ksi+QLOOARjRSBiEgorBgEE
 AZdVAQUBAQdAqoMhGmiXJ3DMGeXrlaDA+v/aF/ah7ARbFV4ukHyz+CkDAQgHwngEGBYKACAW
 IQQ5DAcjaM+IvmZPLohVg4tqeAbEAgUCY0UgYgIbDAAKCRBVg4tqeAbEAtjHAQDkh5jZRIsZ
 7JMNkPMSCd5PuSy0/Gdx8LGgsxxPMZwePgEAn5Tnh4fVbf00esnoK588bYQgJBioXtuXhtom
 8hlxFQM=
In-Reply-To: <9ffce724-23c9-4aa1-bc53-8292e1029991@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi David!

On Wed, 2025-02-26 at 15:30 +0000, David Hildenbrand wrote:
> On 26.02.25 16:14, Patrick Roy wrote:
>>
>>
>> On Wed, 2025-02-26 at 09:08 +0000, David Hildenbrand wrote:
>>> On 26.02.25 09:48, Patrick Roy wrote:
>>>>
>>>>
>>>> On Tue, 2025-02-25 at 16:54 +0000, David Hildenbrand wrote:> On 21.02.25 17:07, Patrick Roy wrote:
>>>>>> Add KVM_GMEM_NO_DIRECT_MAP flag for KVM_CREATE_GUEST_MEMFD() ioctl. When
>>>>>> set, guest_memfd folios will be removed from the direct map after
>>>>>> preparation, with direct map entries only restored when the folios are
>>>>>> freed.
>>>>>>
>>>>>> To ensure these folios do not end up in places where the kernel cannot
>>>>>> deal with them, set AS_NO_DIRECT_MAP on the guest_memfd's struct
>>>>>> address_space if KVM_GMEM_NO_DIRECT_MAP is requested.
>>>>>>
>>>>>> Note that this flag causes removal of direct map entries for all
>>>>>> guest_memfd folios independent of whether they are "shared" or "private"
>>>>>> (although current guest_memfd only supports either all folios in the
>>>>>> "shared" state, or all folios in the "private" state if
>>>>>> !IS_ENABLED(CONFIG_KVM_GMEM_SHARED_MEM)). The usecase for removing
>>>>>> direct map entries of also the shared parts of guest_memfd are a special
>>>>>> type of non-CoCo VM where, host userspace is trusted to have access to
>>>>>> all of guest memory, but where Spectre-style transient execution attacks
>>>>>> through the host kernel's direct map should still be mitigated.
>>>>>>
>>>>>> Note that KVM retains access to guest memory via userspace
>>>>>> mappings of guest_memfd, which are reflected back into KVM's memslots
>>>>>> via userspace_addr. This is needed for things like MMIO emulation on
>>>>>> x86_64 to work. Previous iterations attempted to instead have KVM
>>>>>> temporarily restore direct map entries whenever such an access to guest
>>>>>> memory was needed, but this turned out to have a significant performance
>>>>>> impact, as well as additional complexity due to needing to refcount
>>>>>> direct map reinsertion operations and making them play nicely with gmem
>>>>>> truncations.
>>>>>>
>>>>>> This iteration also doesn't have KVM perform TLB flushes after direct
>>>>>> map manipulations. This is because TLB flushes resulted in a up to 40x
>>>>>> elongation of page faults in guest_memfd (scaling with the number of CPU
>>>>>> cores), or a 5x elongation of memory population. On the one hand, TLB
>>>>>> flushes are not needed for functional correctness (the virt->phys
>>>>>> mapping technically stays "correct",  the kernel should simply to not it
>>>>>> for a while), so this is a correct optimization to make. On the other
>>>>>> hand, it means that the desired protection from Spectre-style attacks is
>>>>>> not perfect, as an attacker could try to prevent a stale TLB entry from
>>>>>> getting evicted, keeping it alive until the page it refers to is used by
>>>>>> the guest for some sensitive data, and then targeting it using a
>>>>>> spectre-gadget.
>>>>>>
>>>>>> Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
>>>>>
>>>>> ...
>>>>>
>>>>>>
>>>>>> +static bool kvm_gmem_test_no_direct_map(struct inode *inode)
>>>>>> +{
>>>>>> +     return ((unsigned long) inode->i_private) & KVM_GMEM_NO_DIRECT_MAP;
>>>>>> +}
>>>>>> +
>>>>>>     static inline void kvm_gmem_mark_prepared(struct folio *folio)
>>>>>>     {
>>>>>> +     struct inode *inode = folio_inode(folio);
>>>>>> +
>>>>>> +     if (kvm_gmem_test_no_direct_map(inode)) {
>>>>>> +             int r = set_direct_map_valid_noflush(folio_page(folio, 0), folio_nr_pages(folio),
>>>>>> +                                                  false);
>>>>>
>>>>> Will this work if KVM is built as a module, or is this another good
>>>>> reason why we might want guest_memfd core part of core-mm?
>>>>
>>>> mh, I'm admittedly not too familiar with the differences that would come
>>>> from building KVM as a module vs not. I do remember something about the
>>>> direct map accessors not being available for modules, so this would
>>>> indeed not work. Does that mean moving gmem into core-mm will be a
>>>> pre-requisite for the direct map removal stuff?
>>>
>>> Likely, we'd need some shim.
>>>
>>> Maybe for the time being it could be fenced using #if IS_BUILTIN() ...
>>> but that sure won't win in a beauty contest.
>>
>> Is anyone working on such a shim at the moment? Otherwise, would it make
>> sense for me to look into it? (although I'll probably need a pointer or
>> two for what is actually needed)
>>
>> I saw your comment on Fuad's series [1] indicating that he'll also need
>> some shim, so probably makes sense to tackle it anyway instead of
>> hacking around it with #if-ery.
> 
> Elliot (CC) was working on "guestmem library" project [1], but it was
> unclear what we could factor out into the core.
> 
> Looks like a simple shim for such stuff might be a good starting point,
> although not the final idea of encapsulating more in the library.

So I started looking into this based on what we talked about at the last
guest_memfd sync. I tried to sort of go the way you hinted at when this
topic of "direct map removal from modules" came up in the past [1], and
hide it behind some sort of "alloc/free" abstraction. E.g. have the
library/shim expose gmem_get_folio(struct inode *inode, pgoff_t index)
that is a sorta equivalent of today __kvm_gmem_get_pfn(), which grabs a
new folio from the filemap, prepares it via a callback provided by KVM,
and then direct map removes it before returning it proper. But then,
that could still be "abused" by module code to just remove arbitrary
folios from the direct map, if a caller messed up any old struct inode
to look sufficiently like a gmem inode for the purposes of
gmem_get_folio(). But I also couldn't really come up with anything that
_wouldn't_ allow something like this. What're your thoughts on this? Do
we need to find a way to prevent this sort of stuff, and is that even
possible? I checked some of Elliot's old submissions that contain
direct map removal as part of the library and they run into the
same problem.

Best, 
Patrick

[1]: https://lore.kernel.org/all/49d14780-56f4-478d-9f5f-0857e788c667@redhat.com/
 
> @Elliot, are you currently still looking into this?
>
> [1]
> https://lore.kernel.org/all/20241113-guestmem-library-v3-0-71fdee85676b@quicinc.com/T/#u
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

