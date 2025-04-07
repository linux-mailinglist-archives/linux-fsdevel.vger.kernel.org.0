Return-Path: <linux-fsdevel+bounces-45860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B78E9A7DBD8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 13:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2E6E16919B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 11:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD46123AE70;
	Mon,  7 Apr 2025 11:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="pW79+9FK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1FC22B8C3;
	Mon,  7 Apr 2025 11:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744023877; cv=none; b=SHaItzAMLb0KxMHIbYVPS+PiD7DVjUNyjhQJx1h8Rd4XLUFERgauh/bgsvFIdgKWxtg2k1Fs998HVsXtysBYEwBASr25pwr8m4tmjeUN/VNvkPVK+IbhzbqgSA2PBIUr8gz2M75qFYV6nc3iUTYFv4S9ROJam6cb0vckEX6Unhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744023877; c=relaxed/simple;
	bh=qVVkFfVrP9/MjErGai73dJ7oVrtY/oNm438X3fdHpF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gwoLnJvvb1hyCTP8zjtnKBYP68lL9onZkw2t5YJbpG6rVJQU9rhYJx48wF27ZVMKLUJJyCf0bH1Texavbj1pNrGxE+8YQUl0qRJyZLM+cLdNYvhUfcrbS3dGGl/eHPmVTdNstSTHjctSzYpXjxv4Uu2sX1XsI1ekJGz6A4mO9qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=pW79+9FK; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744023875; x=1775559875;
  h=message-id:date:mime-version:reply-to:subject:to:
   references:from:in-reply-to:content-transfer-encoding;
  bh=ZjRA+PTfzs7vIA+H3U+wmpf+wbxMWwp7rlbhH+fAXlM=;
  b=pW79+9FKDLMj8MRdRhImqGcxfHO1NHgKr9Np3Fk3KhjNrfKBc/h6piz2
   b4KntKsdmZzpjbvT/T0yotu4Ej8lCCrflO9+H2E9QOfL1YEtFSKmr1jTF
   Ova2hqPVfC+In9QeJ8O4ZdqByT1DWearDbxfF+I1NnTzVc5/Hrxhrj6nn
   g=;
X-IronPort-AV: E=Sophos;i="6.15,194,1739836800"; 
   d="scan'208";a="478128755"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 11:04:31 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.10.100:44174]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.10.171:2525] with esmtp (Farcaster)
 id 6feef606-9eb5-46eb-875a-5973d50aa482; Mon, 7 Apr 2025 11:04:30 +0000 (UTC)
X-Farcaster-Flow-ID: 6feef606-9eb5-46eb-875a-5973d50aa482
Received: from EX19D022EUC002.ant.amazon.com (10.252.51.137) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 7 Apr 2025 11:04:30 +0000
Received: from [192.168.3.31] (10.106.83.24) by EX19D022EUC002.ant.amazon.com
 (10.252.51.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14; Mon, 7 Apr 2025
 11:04:29 +0000
Message-ID: <e8abe599-f48f-4203-8c60-9ee776aa4a24@amazon.com>
Date: Mon, 7 Apr 2025 12:04:28 +0100
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
In-Reply-To: <2iggdfimgfke5saxs74zmfrswgrxmmsyxzphq4mdfpj54wu4pl@5uiia4pzkxem>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D010EUC002.ant.amazon.com (10.252.51.160) To
 EX19D022EUC002.ant.amazon.com (10.252.51.137)



On 04/04/2025 18:12, Liam R. Howlett wrote:
> +To authors of v7 series referenced in [1]
> 
> * Nikita Kalyazin <kalyazin@amazon.com> [250404 11:44]:
>> This series is built on top of the Fuad's v7 "mapping guest_memfd backed
>> memory at the host" [1].
> 
> I didn't see their addresses in the to/cc, so I added them to my
> response as I reference the v7 patch set below.

Hi Liam,

Thanks for the feedback and for extending the list.

> 
>>
>> With James's KVM userfault [2], it is possible to handle stage-2 faults
>> in guest_memfd in userspace.  However, KVM itself also triggers faults
>> in guest_memfd in some cases, for example: PV interfaces like kvmclock,
>> PV EOI and page table walking code when fetching the MMIO instruction on
>> x86.  It was agreed in the guest_memfd upstream call on 23 Jan 2025 [3]
>> that KVM would be accessing those pages via userspace page tables.
> 
> Thanks for being open about the technical call, but it would be better
> to capture the reasons and not the call date.  I explain why in the
> linking section as well.

Thanks for bringing that up.  The document mostly contains the decision 
itself.  The main alternative considered previously was a temporary 
reintroduction of the pages to the direct map whenever a KVM-internal 
access is required.  It was coming with a significant complexity of 
guaranteeing correctness in all cases [1].  Since the memslot structure 
already contains a guest memory pointer supplied by the userspace, KVM 
can use it directly when in the VMM or vCPU context.  I will add this in 
the cover for the next version.

[1] 
https://lore.kernel.org/kvm/20240709132041.3625501-1-roypat@amazon.co.uk/T/#m4f367c52bbad0f0ba7fb07ca347c7b37258a73e5

> 
>> In
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
> 
> Please slow down...
> 
> This patch is at v3, the v7 patch that you are building off has lockdep
> issues [1] reported by one of the authors, and (sorry for sounding harsh
> about the v7 of that patch) the cover letter reads a bit more like an
> RFC than a set ready to go into linux-mm.

AFAIK the lockdep issue was reported on a v7 of a different change.
I'm basing my series on [2] ("KVM: Mapping guest_memfd backed memory at 
the host for software protected VMs"), while the issue was reported on 
[2] ("KVM: Restricted mapping of guest_memfd at the host and arm64 
support"), which is also built on top of [2].  Please correct me if I'm 
missing something.

The key feature that is required by my series is the ability to mmap 
guest_memfd when the VM type allows.  My understanding is no-one is 
opposed to that as of now, that's why I assumed it's safe to build on 
top of that.

[2] https://lore.kernel.org/kvm/20250318161823.4005529-1-tabba@google.com/T/
[3] 
https://lore.kernel.org/all/diqz1puanquh.fsf@ackerleytng-ctop.c.googlers.com/T/

> 
> Maybe the lockdep issue is just a patch ordering thing or removed in a
> later patch set, but that's not mentioned in the discovery email?
> 
> What exactly is the goal here and the path forward for the rest of us
> trying to build on this once it's in mm-new/mm-unstable?
> 
> Note that mm-unstable is shared with a lot of other people through
> linux-next, and we are really trying to stop breaking stuff on them.
> 
> Obviously v7 cannot go in until it works with lockdep - otherwise none
> of us can use lockdep which is not okay.
> 
> Also, I am concerned about the amount of testing in the v7 and v3 patch
> sets that did not bring up a lockdep issue..
> 
>>
>> [1] https://lore.kernel.org/kvm/20250318161823.4005529-1-tabba@google.com/T/
>> [2] https://lore.kernel.org/kvm/20250109204929.1106563-1-jthoughton@google.com/T/
>> [3] https://docs.google.com/document/d/1M6766BzdY1Lhk7LiR5IqVR8B8mG3cr-cxTxOrAosPOk/edit?tab=t.0#heading=h.w1126rgli5e3
> 
> If there is anything we need to know about the decisions in the call and
> that document, can you please pull it into this change log?
> 
> I don't think anyone can ensure google will not rename docs to some
> other office theme tomorrow - as they famously ditch basically every
> name and application.
> 
> Also, most of the community does not want to go to a 17 page (and
> growing) spreadsheet to hunt down the facts when there is an acceptable
> and ideal place to document them in git.  It's another barrier of entry
> on reviewing your code as well.
> 
> But please, don't take this suggestion as carte blanche for copying a
> conversation from the doc, just give us the technical reasons for your
> decisions as briefly as possible.
> 
> 
>> [4] https://lore.kernel.org/kvm/20250402160721.97596-1-kalyazin@amazon.com/T/
> 
> [1]. https://lore.kernel.org/all/diqz1puanquh.fsf@ackerleytng-ctop.c.googlers.com/
> 
> Thanks,
> Liam


