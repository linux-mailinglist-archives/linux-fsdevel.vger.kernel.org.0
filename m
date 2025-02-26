Return-Path: <linux-fsdevel+bounces-42672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD4BA458C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 09:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 914893AABCC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 08:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B2A217F31;
	Wed, 26 Feb 2025 08:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="Ib53PPsc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154C218DB3B;
	Wed, 26 Feb 2025 08:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740559713; cv=none; b=rFnncRI2ho2SyY0LcCkERFDDuCSIexy/4lt0exvNjBv4c8qiZ3m3T+B0YQbdfBBai+UKqLQTnp7utfL/tbKqHn9VN4teUhEfQMlyn59lxu8VJKQmchPUKLpFgzvXF3TULLMBj7Msxm5UmUY4X4Sdy42JCc8JZFcU/Bx/41jeiB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740559713; c=relaxed/simple;
	bh=+WodfQjsBZG487J0gzQOBPl0Z/0CzB+qFN+2/p2Ms3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fFssDZ1uJOosq4y/dATx95NhtZ1m5Tul5OaxPP1/8tR6dciqo1/QbbturEuy/O7cHeUfMdw4gL3HUDDqcvaua6116xlBq0YR/Z2VJenaZKu9VZSfT6akvAjeyKC2gvlEH/tbQWEvKJfmryHwThTcqX90KgdbgpPcx4NzKOmOrD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=Ib53PPsc; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1740559712; x=1772095712;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qF79yHjpoNZOP3Yj4UirgbH8x7O0W6H8pZSYrcLmHaU=;
  b=Ib53PPscEwvJpgcDN5HFn4LuAhkhaxdRAH8ZKM99CAMnCUOMlOGHWBap
   wBWVjdsGcTtOpJTSsLxtxDax9IZotzb67iWMK0h0KfSVM4gWfa8uTQSc9
   uxTMWYk1eui/oQs4pbA57S4GfwIBHSm6seJLtSo+ZwPA/zd6Bu4nrRpUk
   c=;
X-IronPort-AV: E=Sophos;i="6.13,316,1732579200"; 
   d="scan'208";a="497310661"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 08:48:27 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:29533]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.181:2525] with esmtp (Farcaster)
 id 74ff41ae-9755-4ae7-b352-87edb65d8925; Wed, 26 Feb 2025 08:48:26 +0000 (UTC)
X-Farcaster-Flow-ID: 74ff41ae-9755-4ae7-b352-87edb65d8925
Received: from EX19D020UWC002.ant.amazon.com (10.13.138.147) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 26 Feb 2025 08:48:26 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19D020UWC002.ant.amazon.com (10.13.138.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 26 Feb 2025 08:48:26 +0000
Received: from email-imr-corp-prod-pdx-1box-2b-8c2c6aed.us-west-2.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 08:48:26 +0000
Received: from [127.0.0.1] (dev-dsk-roypat-1c-dbe2a224.eu-west-1.amazon.com [172.19.88.180])
	by email-imr-corp-prod-pdx-1box-2b-8c2c6aed.us-west-2.amazon.com (Postfix) with ESMTPS id AE19FA0135;
	Wed, 26 Feb 2025 08:48:18 +0000 (UTC)
Message-ID: <8642de57-553a-47ec-81af-803280a360ec@amazon.co.uk>
Date: Wed, 26 Feb 2025 08:48:16 +0000
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
	<derekmn@amazon.com>, <jthoughton@google.com>
References: <20250221160728.1584559-1-roypat@amazon.co.uk>
 <20250221160728.1584559-4-roypat@amazon.co.uk>
 <a3178c50-2e76-4743-8008-9a33bd0af93f@redhat.com>
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
In-Reply-To: <a3178c50-2e76-4743-8008-9a33bd0af93f@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit



On Tue, 2025-02-25 at 16:54 +0000, David Hildenbrand wrote:> On 21.02.25 17:07, Patrick Roy wrote:
>> Add KVM_GMEM_NO_DIRECT_MAP flag for KVM_CREATE_GUEST_MEMFD() ioctl. When
>> set, guest_memfd folios will be removed from the direct map after
>> preparation, with direct map entries only restored when the folios are
>> freed.
>>
>> To ensure these folios do not end up in places where the kernel cannot
>> deal with them, set AS_NO_DIRECT_MAP on the guest_memfd's struct
>> address_space if KVM_GMEM_NO_DIRECT_MAP is requested.
>>
>> Note that this flag causes removal of direct map entries for all
>> guest_memfd folios independent of whether they are "shared" or "private"
>> (although current guest_memfd only supports either all folios in the
>> "shared" state, or all folios in the "private" state if
>> !IS_ENABLED(CONFIG_KVM_GMEM_SHARED_MEM)). The usecase for removing
>> direct map entries of also the shared parts of guest_memfd are a special
>> type of non-CoCo VM where, host userspace is trusted to have access to
>> all of guest memory, but where Spectre-style transient execution attacks
>> through the host kernel's direct map should still be mitigated.
>>
>> Note that KVM retains access to guest memory via userspace
>> mappings of guest_memfd, which are reflected back into KVM's memslots
>> via userspace_addr. This is needed for things like MMIO emulation on
>> x86_64 to work. Previous iterations attempted to instead have KVM
>> temporarily restore direct map entries whenever such an access to guest
>> memory was needed, but this turned out to have a significant performance
>> impact, as well as additional complexity due to needing to refcount
>> direct map reinsertion operations and making them play nicely with gmem
>> truncations.
>>
>> This iteration also doesn't have KVM perform TLB flushes after direct
>> map manipulations. This is because TLB flushes resulted in a up to 40x
>> elongation of page faults in guest_memfd (scaling with the number of CPU
>> cores), or a 5x elongation of memory population. On the one hand, TLB
>> flushes are not needed for functional correctness (the virt->phys
>> mapping technically stays "correct",  the kernel should simply to not it
>> for a while), so this is a correct optimization to make. On the other
>> hand, it means that the desired protection from Spectre-style attacks is
>> not perfect, as an attacker could try to prevent a stale TLB entry from
>> getting evicted, keeping it alive until the page it refers to is used by
>> the guest for some sensitive data, and then targeting it using a
>> spectre-gadget.
>>
>> Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
> 
> ...
> 
>>
>> +static bool kvm_gmem_test_no_direct_map(struct inode *inode)
>> +{
>> +     return ((unsigned long) inode->i_private) & KVM_GMEM_NO_DIRECT_MAP;
>> +}
>> +
>>   static inline void kvm_gmem_mark_prepared(struct folio *folio)
>>   {
>> +     struct inode *inode = folio_inode(folio);
>> +
>> +     if (kvm_gmem_test_no_direct_map(inode)) {
>> +             int r = set_direct_map_valid_noflush(folio_page(folio, 0), folio_nr_pages(folio),
>> +                                                  false);
> 
> Will this work if KVM is built as a module, or is this another good
> reason why we might want guest_memfd core part of core-mm?

mh, I'm admittedly not too familiar with the differences that would come
from building KVM as a module vs not. I do remember something about the
direct map accessors not being available for modules, so this would
indeed not work. Does that mean moving gmem into core-mm will be a
pre-requisite for the direct map removal stuff?

> -- 
> Cheers,
> 
> David / dhildenb
> 

Best, 
Patrick

