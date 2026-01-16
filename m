Return-Path: <linux-fsdevel+bounces-74155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CFCD3309C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 16:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5570B302F95F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 15:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1CC339857;
	Fri, 16 Jan 2026 15:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="bfTA0kZ2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.197.217.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9BF337119;
	Fri, 16 Jan 2026 15:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.197.217.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768575679; cv=none; b=DGlqy0Ko/iv1QJd17W7DYF5TU5kR33bYvfpjC6iU937O0UFWfn8nNbaj0XOBWUOZF9vbq+Ukemh2mKaeiy+M2D4oJVoCFuV43wbujt9ONgus+UGQm3tC0M/VsKt23+GQcpOV6QdSOkRLF5WZJe7Dsux33ZgcX4ZY0XdQsVJMVCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768575679; c=relaxed/simple;
	bh=U8gAcKLYchfyCxoQGSkrSGDmCwOQNAdH0aT/zLUXDTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=e3emqx1heobV/tMqNQbq8MHvdPt05GtKFa9hpERjK/AGOvEMwtp22BFJk5+kd+0HnHu1wdKAvaClphyzGqmi8dfTfHZnAexV1DFuYziGDrJoVIj5wx7olZAWHfQvy/LF+YsYMCK9HntMqUi4dOA7doxzUgi4MrBlxWd4L8XgwQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=bfTA0kZ2; arc=none smtp.client-ip=18.197.217.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1768575678; x=1800111678;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=aTijkiEgAEgLfBD3f1GYfjv2OO1D0EQ13p+mBFzBwWI=;
  b=bfTA0kZ21VUQU3hKVLPUeM0n34Du9uk08pWxVFlpEKGHdsVIkTKp4err
   G3DBCZcUd4v+hLy4HD/gSNnfZuavJO6WkrF2bdwSEI5lW1iNoi7UA229Y
   HbBATKKqjtYd8bNnzfdgCppEOpHHcshu4CqYKfnc8YwkV0iU6+PLBf5rJ
   4tXQmnq/gXMpfkeMT93LzuJl19NzW9FS9by75QBw6Yi4pMdhY5MEgLuLS
   +b1jkkut6BEbU+S2+5fVqr7KIri1a+YDbaBpsNQ7I7oArbclqyAvLGljL
   wu73n+ouGIvbEtZn5gGQXoRbOgjBFsxODhEYrSSe8EeCeuEaMOHT8w2rC
   g==;
X-CSE-ConnectionGUID: Lgi63RilSou9/V8Gr9JAeg==
X-CSE-MsgGUID: ZoyC9RCmSGGaLDhTiRhoog==
X-IronPort-AV: E=Sophos;i="6.21,231,1763424000"; 
   d="scan'208";a="8022697"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 15:01:00 +0000
Received: from EX19MTAEUA002.ant.amazon.com [54.240.197.232:5028]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.30.60:2525] with esmtp (Farcaster)
 id d65bbded-3f2b-45ea-90e0-dd1ca16777be; Fri, 16 Jan 2026 15:00:59 +0000 (UTC)
X-Farcaster-Flow-ID: d65bbded-3f2b-45ea-90e0-dd1ca16777be
Received: from EX19D005EUB003.ant.amazon.com (10.252.51.31) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Fri, 16 Jan 2026 15:00:58 +0000
Received: from [192.168.12.13] (10.106.82.9) by EX19D005EUB003.ant.amazon.com
 (10.252.51.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35; Fri, 16 Jan 2026
 15:00:54 +0000
Message-ID: <04173297-518d-460a-be9f-502d32cbe509@amazon.com>
Date: Fri, 16 Jan 2026 15:00:53 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v9 09/13] KVM: selftests: set KVM_MEM_GUEST_MEMFD in
 vm_mem_add() if guest_memfd != -1
To: Ackerley Tng <ackerleytng@google.com>, "Kalyazin, Nikita"
	<kalyazin@amazon.co.uk>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"kernel@xen0n.name" <kernel@xen0n.name>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, "loongarch@lists.linux.dev"
	<loongarch@lists.linux.dev>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "maz@kernel.org" <maz@kernel.org>, "oupton@kernel.org"
	<oupton@kernel.org>, "joey.gouly@arm.com" <joey.gouly@arm.com>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "yuzenghui@huawei.com"
	<yuzenghui@huawei.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "luto@kernel.org"
	<luto@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>,
	"willy@infradead.org" <willy@infradead.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "david@kernel.org" <david@kernel.org>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "vbabka@suse.cz"
	<vbabka@suse.cz>, "rppt@kernel.org" <rppt@kernel.org>, "surenb@google.com"
	<surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>, "ast@kernel.org"
	<ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"andrii@kernel.org" <andrii@kernel.org>, "martin.lau@linux.dev"
	<martin.lau@linux.dev>, "eddyz87@gmail.com" <eddyz87@gmail.com>,
	"song@kernel.org" <song@kernel.org>, "yonghong.song@linux.dev"
	<yonghong.song@linux.dev>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "kpsingh@kernel.org" <kpsingh@kernel.org>,
	"sdf@fomichev.me" <sdf@fomichev.me>, "haoluo@google.com" <haoluo@google.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, "peterx@redhat.com"
	<peterx@redhat.com>, "jannh@google.com" <jannh@google.com>,
	"pfalcato@suse.de" <pfalcato@suse.de>, "shuah@kernel.org" <shuah@kernel.org>,
	"riel@surriel.com" <riel@surriel.com>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>, "jgross@suse.com" <jgross@suse.com>,
	"yu-cheng.yu@intel.com" <yu-cheng.yu@intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "coxu@redhat.com" <coxu@redhat.com>,
	"kevin.brodsky@arm.com" <kevin.brodsky@arm.com>, "maobibo@loongson.cn"
	<maobibo@loongson.cn>, "prsampat@amd.com" <prsampat@amd.com>,
	"mlevitsk@redhat.com" <mlevitsk@redhat.com>, "jmattson@google.com"
	<jmattson@google.com>, "jthoughton@google.com" <jthoughton@google.com>,
	"agordeev@linux.ibm.com" <agordeev@linux.ibm.com>, "alex@ghiti.fr"
	<alex@ghiti.fr>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
	"chenhuacai@kernel.org" <chenhuacai@kernel.org>, "dev.jain@arm.com"
	<dev.jain@arm.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>,
	"hca@linux.ibm.com" <hca@linux.ibm.com>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
	"pjw@kernel.org" <pjw@kernel.org>, "shijie@os.amperecomputing.com"
	<shijie@os.amperecomputing.com>, "svens@linux.ibm.com" <svens@linux.ibm.com>,
	"thuth@redhat.com" <thuth@redhat.com>, "wyihan@google.com"
	<wyihan@google.com>, "yang@os.amperecomputing.com"
	<yang@os.amperecomputing.com>, "vannapurve@google.com"
	<vannapurve@google.com>, "jackmanb@google.com" <jackmanb@google.com>,
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>, "patrick.roy@linux.dev"
	<patrick.roy@linux.dev>, "Thomson, Jack" <jackabt@amazon.co.uk>, "Itazuri,
 Takahiro" <itazur@amazon.co.uk>, "Manwaring, Derek" <derekmn@amazon.com>,
	"Cali, Marco" <xmarcalx@amazon.co.uk>
References: <20260114134510.1835-1-kalyazin@amazon.com>
 <20260114134510.1835-10-kalyazin@amazon.com>
 <CAEvNRgGz2gRu2i+OSxasuyZudqsRGXijbDES8uXVe_hH6QCK4g@mail.gmail.com>
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
In-Reply-To: <CAEvNRgGz2gRu2i+OSxasuyZudqsRGXijbDES8uXVe_hH6QCK4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D010EUA004.ant.amazon.com (10.252.50.94) To
 EX19D005EUB003.ant.amazon.com (10.252.51.31)



On 15/01/2026 19:39, Ackerley Tng wrote:
> "Kalyazin, Nikita" <kalyazin@amazon.co.uk> writes:
> 
>> From: Patrick Roy <patrick.roy@linux.dev>
>>
>> Have vm_mem_add() always set KVM_MEM_GUEST_MEMFD in the memslot flags if
>> a guest_memfd is passed in as an argument. This eliminates the
>> possibility where a guest_memfd instance is passed to vm_mem_add(), but
>> it ends up being ignored because the flags argument does not specify
>> KVM_MEM_GUEST_MEMFD at the same time.
>>
>> This makes it easy to support more scenarios in which no vm_mem_add() is
>> not passed a guest_memfd instance, but is expected to allocate one.
>> Currently, this only happens if guest_memfd == -1 but flags &
>> KVM_MEM_GUEST_MEMFD != 0, but later vm_mem_add() will gain support for
>> loading the test code itself into guest_memfd (via
>> GUEST_MEMFD_FLAG_MMAP) if requested via a special
>> vm_mem_backing_src_type, at which point having to make sure the src_type
>> and flags are in-sync becomes cumbersome.
>>
>> Signed-off-by: Patrick Roy <patrick.roy@linux.dev>
>> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
>> ---
>>   tools/testing/selftests/kvm/lib/kvm_util.c | 24 +++++++++++++---------
>>   1 file changed, 14 insertions(+), 10 deletions(-)
>>
>> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
>> index 8279b6ced8d2..56ddbca91850 100644
>> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
>> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
>> @@ -1057,21 +1057,25 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
>>
>>        region->backing_src_type = src_type;
>>
>> -     if (flags & KVM_MEM_GUEST_MEMFD) {
>> -             if (guest_memfd < 0) {
>> +     if (guest_memfd < 0) {
>> +             if (flags & KVM_MEM_GUEST_MEMFD) {
>>                        uint32_t guest_memfd_flags = 0;
>>                        TEST_ASSERT(!guest_memfd_offset,
>>                                    "Offset must be zero when creating new guest_memfd");
>>                        guest_memfd = vm_create_guest_memfd(vm, mem_size, guest_memfd_flags);
>> -             } else {
>> -                     /*
>> -                      * Install a unique fd for each memslot so that the fd
>> -                      * can be closed when the region is deleted without
>> -                      * needing to track if the fd is owned by the framework
>> -                      * or by the caller.
>> -                      */
>> -                     guest_memfd = kvm_dup(guest_memfd);
>>                }
>> +     } else {
>> +             /*
>> +              * Install a unique fd for each memslot so that the fd
>> +              * can be closed when the region is deleted without
>> +              * needing to track if the fd is owned by the framework
>> +              * or by the caller.
>> +              */
>> +             guest_memfd = kvm_dup(guest_memfd);
>> +     }
>> +
>> +     if (guest_memfd > 0) {
> 
> Might 0 turn out to be a valid return from dup() for a guest_memfd?

Yes, you're right, it isn't impossible.  Thanks!

> 
>> +             flags |= KVM_MEM_GUEST_MEMFD;
>>
>>                region->region.guest_memfd = guest_memfd;
>>                region->region.guest_memfd_offset = guest_memfd_offset;
> 
> Refactoring vm_mem_add() (/* FIXME: This thing needs to be ripped apart
> and rewritten. */) should probably be a separate patch series, but I'd
> like to take this opportunity to ask: Sean, what do you have in mind for
> the rewritten version?
> 
> Would it be something like struct vm_shape, where there are default
> mem_shapes, and the shapes get validated and then passed to
> vm_mem_add()?
> 
>> --
>> 2.50.1


