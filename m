Return-Path: <linux-fsdevel+bounces-70844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 781B7CA894F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 18:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3AFE30658F3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 17:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A777435A959;
	Fri,  5 Dec 2025 17:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="o6+Ljyfr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com [63.178.143.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D4D359FB7;
	Fri,  5 Dec 2025 17:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.178.143.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764955453; cv=none; b=oq9/50OPm9NrJ2+y/CoFotby/ofatnBEp+pRkZEjFt88MRCutY2kEjdO+VSJ2mAxFug+FFt9PJ0L+LIf6XmOeEFPWiZJ+dlJHCHW/m9HnyfWCEX4/qLLGP1uMeX5dXqPEu+iSSDjaRoD1cx7qXtRCRVePXaf++us6SfitTH8kZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764955453; c=relaxed/simple;
	bh=VP09C2UJW+dtoiSy9nxfA21fJ8XvlYAq9HNrnEuDVWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=h/vwksfmhUYIn6/4AU9uGrMyECoV7GuMG2A2acIk5eNuvMhy7Ddm4vNGYvWytxwdRS+GXbz52x8zo3ZHlhVK4TAK8U7fsPff9fs6aPknhmjaZP9NDy8IprsMToKiiS/P0sgtdFO2mdd1iFN1vbciPi5Cvh0Ab8HpboJPvq9tqQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=o6+Ljyfr; arc=none smtp.client-ip=63.178.143.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1764955450; x=1796491450;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=DnhB+PvK+wkKdNvTrP/dFYEJueius5f77QIgV9qQQYw=;
  b=o6+Ljyfrd+cYtaN0p9IIZZDVyYu4U6bGn4202v3GWoVq9DTRhqKx1o2i
   lVOr02lT9ZM2oQeuRnkm5n65t8MHslZaqn3PCn9ZUuW8Ce4pwMVcaYl/T
   Ilhw8Abs7YFMunumELcxh+XUk0TtGGLloZAVRQgPAb49gebqSJTf502ho
   IqKhm+2nmx2Xx80VqnLTxrOiU3oIEo0OIRSNqk2Hn2h8N7306NmKkCR8p
   +sxXvn64qwu7pTcJt4JC0f3IzDKYRMlwqe/urkJbIHR5/trgKvERaWD2z
   M2m4Nm19PRvO5iiYec66dHiKnyRFii6vqrgyeTiVaBfP9212tOl4mTGLY
   w==;
X-CSE-ConnectionGUID: ui1OxgzNTLeAgy/kgfWZcQ==
X-CSE-MsgGUID: 0QAryot6QayZ+88faD+iVA==
X-IronPort-AV: E=Sophos;i="6.20,252,1758585600"; 
   d="scan'208";a="6200858"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 17:24:07 +0000
Received: from EX19MTAEUC001.ant.amazon.com [54.240.197.225:5625]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.44.106:2525] with esmtp (Farcaster)
 id 59f2028b-9252-4cab-b235-d8859489381a; Fri, 5 Dec 2025 17:24:06 +0000 (UTC)
X-Farcaster-Flow-ID: 59f2028b-9252-4cab-b235-d8859489381a
Received: from EX19D005EUB003.ant.amazon.com (10.252.51.31) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 5 Dec 2025 17:24:06 +0000
Received: from [192.168.14.68] (10.106.83.5) by EX19D005EUB003.ant.amazon.com
 (10.252.51.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Fri, 5 Dec 2025
 17:24:03 +0000
Message-ID: <359e292c-4173-49c8-8088-257b4c301300@amazon.com>
Date: Fri, 5 Dec 2025 17:24:02 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v7 12/12] KVM: selftests: Test guest execution from direct
 map removed gmem
To: Brendan Jackman <jackmanb@google.com>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "maz@kernel.org" <maz@kernel.org>, "oliver.upton@linux.dev"
	<oliver.upton@linux.dev>, "joey.gouly@arm.com" <joey.gouly@arm.com>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "yuzenghui@huawei.com"
	<yuzenghui@huawei.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"luto@kernel.org" <luto@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "willy@infradead.org" <willy@infradead.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "vbabka@suse.cz"
	<vbabka@suse.cz>, "rppt@kernel.org" <rppt@kernel.org>, "surenb@google.com"
	<surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>, "song@kernel.org"
	<song@kernel.org>, "jolsa@kernel.org" <jolsa@kernel.org>, "ast@kernel.org"
	<ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"andrii@kernel.org" <andrii@kernel.org>, "martin.lau@linux.dev"
	<martin.lau@linux.dev>, "eddyz87@gmail.com" <eddyz87@gmail.com>,
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org"
	<kpsingh@kernel.org>, "sdf@fomichev.me" <sdf@fomichev.me>,
	"haoluo@google.com" <haoluo@google.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, "peterx@redhat.com"
	<peterx@redhat.com>, "jannh@google.com" <jannh@google.com>,
	"pfalcato@suse.de" <pfalcato@suse.de>, "shuah@kernel.org" <shuah@kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Cali,
 Marco" <xmarcalx@amazon.co.uk>, "Kalyazin, Nikita" <kalyazin@amazon.co.uk>,
	"Thomson, Jack" <jackabt@amazon.co.uk>, "derekmn@amazon.co.uk"
	<derekmn@amazon.co.uk>, "tabba@google.com" <tabba@google.com>,
	"ackerleytng@google.com" <ackerleytng@google.com>, "david@kernel.org"
	<david@kernel.org>, "patrick.roy@linux.dev" <patrick.roy@linux.dev>
References: <20250924151101.2225820-4-patrick.roy@campus.lmu.de>
 <20250924152214.7292-1-roypat@amazon.co.uk>
 <20250924152214.7292-9-roypat@amazon.co.uk>
 <DDVTTQZBJXAK.1OC7BTWCVCP9U@google.com>
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
In-Reply-To: <DDVTTQZBJXAK.1OC7BTWCVCP9U@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D004EUA004.ant.amazon.com (10.252.50.183) To
 EX19D005EUB003.ant.amazon.com (10.252.51.31)



On 30/10/2025 17:18, Brendan Jackman wrote:
> On Wed Sep 24, 2025 at 3:22 PM UTC, Patrick Roy wrote:
>> Add a selftest that loads itself into guest_memfd (via
>> GUEST_MEMFD_FLAG_MMAP) and triggers an MMIO exit when executed. This
>> exercises x86 MMIO emulation code inside KVM for guest_memfd-backed
>> memslots where the guest_memfd folios are direct map removed.
>> Particularly, it validates that x86 MMIO emulation code (guest page
>> table walks + instruction fetch) correctly accesses gmem through the VMA
>> that's been reflected into the memslot's userspace_addr field (instead
>> of trying to do direct map accesses).
>>
>> Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
>> ---
>>   .../selftests/kvm/set_memory_region_test.c    | 50 +++++++++++++++++--
>>   1 file changed, 46 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
>> index ce3ac0fd6dfb..cb3bc642d376 100644
>> --- a/tools/testing/selftests/kvm/set_memory_region_test.c
>> +++ b/tools/testing/selftests/kvm/set_memory_region_test.c
>> @@ -603,6 +603,41 @@ static void test_mmio_during_vectoring(void)
>>
>>        kvm_vm_free(vm);
>>   }
>> +
>> +static void guest_code_trigger_mmio(void)
>> +{
>> +     /*
>> +      * Read some GPA that is not backed by a memslot. KVM consider this
>> +      * as MMIO and tell userspace to emulate the read.
>> +      */
>> +     READ_ONCE(*((uint64_t *)MEM_REGION_GPA));
>> +
>> +     GUEST_DONE();
>> +}
>> +
>> +static void test_guest_memfd_mmio(void)
>> +{
>> +     struct kvm_vm *vm;
>> +     struct kvm_vcpu *vcpu;
>> +     struct vm_shape shape = {
>> +             .mode = VM_MODE_DEFAULT,
>> +             .src_type = VM_MEM_SRC_GUEST_MEMFD_NO_DIRECT_MAP,
>> +     };
>> +     pthread_t vcpu_thread;
>> +
>> +     pr_info("Testing MMIO emulation for instructions in gmem\n");
>> +
>> +     vm = __vm_create_shape_with_one_vcpu(shape, &vcpu, 0, guest_code_trigger_mmio);
> 
> When I run this test on my minimal config in a nested VM I get:
> 
> [root@testvm:~]# /nix/store/xlxd60n7v1qfr6s5zxda410zrzdd0xc2-kselftests/bin/run_kselftest.sh -t kvm:set_memory_region_test
> TAP version 13
> 1..1
> # timeout set to 120
> # selftests: kvm: set_memory_region_test
> # Random seed: 0x6b8b4567
> # Testing KVM_RUN with zero added memory regions
> # Testing MMIO during vectoring error handling
> # Allowed number of memory slots: 32764
> # Adding slots 0..32763, each memory region with 2048K size
> # Testing MMIO emulation for instructions in gmem
> # ==== Test Assertion Failure ====
> #   lib/kvm_util.c:1118: region->mmap_start != MAP_FAILED
> #   pid=614 tid=614 errno=19 - No such device
> #      1        0x0000000000407b02: vm_mem_add at ??:?
> #      2        0x000000000040a924: __vm_create at ??:?
> #      3        0x000000000040ab16: __vm_create_shape_with_one_vcpu at ??:?
> #      4        0x00000000004042cf: main at ??:?
> #      5        0x00007faa6b08a47d: ?? ??:0
> #      6        0x00007faa6b08a538: ?? ??:0
> #      7        0x0000000000404384: _start at ??:?
> #   mmap() failed, rc: -1 errno: 19 (No such device)
> 
> Here's the kconfig I'm using (basically defconfig+KVM):
> 
> https://gist.githubusercontent.com/bjackman/4ea941ef5072606769211f3b000c8ed7/raw/73808882ddae6ff2ae8a0be85ac977b2980f7292/kconfig.txt
> 
> Sorry I'm too ignorant about KVM to know what I'm missing here but I
> guess it's a missing TEST_REQUIRE()?

Hi Brendan,

I ran the set_memory_region_test on the v8 [1] with your config with 
minor modifications (I had to enable XFS to be able to mount my rootfs 
and THP as the test appeared to depend on it), and was not able to 
reproduce the failure.  Please let me know whether the v8 still fails 
for you if you have time to try it.

[1] https://lore.kernel.org/kvm/20251205165743.9341-1-kalyazin@amazon.com

Nikita

> 


