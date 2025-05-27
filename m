Return-Path: <linux-fsdevel+bounces-49898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD30AC4AC1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 10:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C116A17CA37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 May 2025 08:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B692F24DD11;
	Tue, 27 May 2025 08:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AokIbjWD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E19B24DCF4;
	Tue, 27 May 2025 08:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748336049; cv=none; b=iRpE3bM9WF4cUU10rnDNIHW+XP7Ae/10SodeBXbcaV8We8iQihAEuvHUTVz8AyskHD9C3kf1dmQ4fyEs6Tj9cLBjx4wYAtUPgcYjjMCRjnYc4b9DH/i7WvUercHckbrgb9Y1eY+y2/CSrF4hesZvuLhf9PdAaWzft5bpnqPOg4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748336049; c=relaxed/simple;
	bh=ahN1juhOBybAptIvDNG/Uw4hA0zokWa6fSCXBMIa8ZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n2UQcxTjO5gmaZAE3lXE29S1vBUxD/UgurErAVj18m4n552fcTGuJNzeLmzbyb/MEIZOHSfeEaTOzPfCQNdTm7HUdbxlQg/2r3sm985Nte2aLsN923sK16L/9LVTLC6W81JXvK7KyuVUOE0I1nKKFppKj2katJRI9ijJlc/U/Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AokIbjWD; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748336047; x=1779872047;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ahN1juhOBybAptIvDNG/Uw4hA0zokWa6fSCXBMIa8ZQ=;
  b=AokIbjWDa8jXkKJLrR+vqWqvCXmdQ8Ljn1+SvjcvlToZoa0G927Y2kQO
   1EN9fHb79Pj1AjGmvaICX+1To1nfyiUOS8/X+auVsfb6hin+vtFjTBY6X
   iLsa90ehVtJfqpP0O21a+HdA/yw+gkmWjaOMphHZygw6u+OkLpwqyVEQh
   +yGLoEQXXaEN7krJiyrq5BACuGs5pgGkeyx8BMQzn+Ny3v3iIndsJbDyO
   yWQk+12NBdZ+AGMzU+AACpPderNS3xEm8KohEJhNXCi+vvZAuFLHig0Qw
   10HY3oL3Dw0o/9U7m5kZmG2pFkaSo8jKtI4+Tyv6v/Fi8h77mwcMAneGj
   g==;
X-CSE-ConnectionGUID: Wncp+vI/RNGk+GoE0mwgfg==
X-CSE-MsgGUID: L/L0pOddRHinkE2tPM0zaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="50473919"
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; 
   d="scan'208";a="50473919"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 01:54:06 -0700
X-CSE-ConnectionGUID: DJWU2wIBQVGR2iHz4Ab5dQ==
X-CSE-MsgGUID: mwknysU4Q3qMo9InnvRemg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; 
   d="scan'208";a="142717170"
Received: from unknown (HELO [10.238.11.3]) ([10.238.11.3])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 01:53:47 -0700
Message-ID: <1c5cfc23-3f63-404d-a4bf-030c24412b20@linux.intel.com>
Date: Tue, 27 May 2025 16:53:43 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 03/51] KVM: selftests: Update guest_memfd_test for
 INIT_PRIVATE flag
To: Ackerley Tng <ackerleytng@google.com>, Ira Weiny <ira.weiny@intel.com>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-fsdevel@vger.kernel.org, aik@amd.com,
 ajones@ventanamicro.com, akpm@linux-foundation.org, amoorthy@google.com,
 anthony.yznaga@oracle.com, anup@brainfault.org, aou@eecs.berkeley.edu,
 bfoster@redhat.com, brauner@kernel.org, catalin.marinas@arm.com,
 chao.p.peng@intel.com, chenhuacai@kernel.org, dave.hansen@intel.com,
 david@redhat.com, dmatlack@google.com, dwmw@amazon.co.uk,
 erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, graf@amazon.com,
 haibo1.xu@intel.com, hch@infradead.org, hughd@google.com,
 isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com,
 jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com,
 jroedel@suse.de, jthoughton@google.com, jun.miao@intel.com,
 kai.huang@intel.com, keirf@google.com, kent.overstreet@linux.dev,
 kirill.shutemov@intel.com, liam.merwick@oracle.com,
 maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, maz@kernel.org,
 mic@digikod.net, michael.roth@amd.com, mpe@ellerman.id.au,
 muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es,
 oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com,
 paul.walmsley@sifive.com, pbonzini@redhat.com, pdurrant@amazon.co.uk,
 peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, qperret@google.com,
 quic_cvanscha@quicinc.com, quic_eberman@quicinc.com,
 quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com,
 quic_pheragu@quicinc.com, quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com,
 richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, rientjes@google.com,
 roypat@amazon.co.uk, rppt@kernel.org, seanjc@google.com, shuah@kernel.org,
 steven.price@arm.com, steven.sistare@oracle.com, suzuki.poulose@arm.com,
 tabba@google.com, thomas.lendacky@amd.com, usama.arif@bytedance.com,
 vannapurve@google.com, vbabka@suse.cz, viro@zeniv.linux.org.uk,
 vkuznets@redhat.com, wei.w.wang@intel.com, will@kernel.org,
 willy@infradead.org, xiaoyao.li@intel.com, yan.y.zhao@intel.com,
 yilun.xu@intel.com, yuzenghui@huawei.com, zhiquan1.li@intel.com
References: <cover.1747264138.git.ackerleytng@google.com>
 <65afac3b13851c442c72652904db6d5755299615.1747264138.git.ackerleytng@google.com>
 <6825f0f3ac8a7_337c392942d@iweiny-mobl.notmuch>
 <diqzmsbcfo4o.fsf@ackerleytng-ctop.c.googlers.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <diqzmsbcfo4o.fsf@ackerleytng-ctop.c.googlers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/17/2025 1:42 AM, Ackerley Tng wrote:
> Ira Weiny <ira.weiny@intel.com> writes:
>
>> Ackerley Tng wrote:
>>> Test that GUEST_MEMFD_FLAG_INIT_PRIVATE is only valid when
>>> GUEST_MEMFD_FLAG_SUPPORT_SHARED is set.
>>>
>>> Change-Id: I506e236a232047cfaee17bcaed02ee14c8d25bbb
>>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>>> ---
>>>   .../testing/selftests/kvm/guest_memfd_test.c  | 36 ++++++++++++-------
>>>   1 file changed, 24 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
>>> index 60aaba5808a5..bf2876cbd711 100644
>>> --- a/tools/testing/selftests/kvm/guest_memfd_test.c
>>> +++ b/tools/testing/selftests/kvm/guest_memfd_test.c
>>> @@ -401,13 +401,31 @@ static void test_with_type(unsigned long vm_type, uint64_t guest_memfd_flags,
>>>   	kvm_vm_release(vm);
>>>   }
>>>   
>>> +static void test_vm_with_gmem_flag(struct kvm_vm *vm, uint64_t flag,
>>> +				   bool expect_valid)
>>> +{
>>> +	size_t page_size = getpagesize();
>>> +	int fd;
>>> +
>>> +	fd = __vm_create_guest_memfd(vm, page_size, flag);
>>> +
>>> +	if (expect_valid) {
>>> +		TEST_ASSERT(fd > 0,
>>> +			    "guest_memfd() with flag '0x%lx' should be valid",
>>> +			    flag);
>>> +		close(fd);
>>> +	} else {
>>> +		TEST_ASSERT(fd == -1 && errno == EINVAL,
>>> +			    "guest_memfd() with flag '0x%lx' should fail with EINVAL",
>>> +			    flag);
>>> +	}
>>> +}
>>> +
>>>   static void test_vm_type_gmem_flag_validity(unsigned long vm_type,
>>>   					    uint64_t expected_valid_flags)
>>>   {
>>> -	size_t page_size = getpagesize();
>>>   	struct kvm_vm *vm;
>>>   	uint64_t flag = 0;
>>> -	int fd;
>>>   
>>>   	if (!(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(vm_type)))
>>>   		return;
>>> @@ -415,17 +433,11 @@ static void test_vm_type_gmem_flag_validity(unsigned long vm_type,
>>>   	vm = vm_create_barebones_type(vm_type);
>>>   
>>>   	for (flag = BIT(0); flag; flag <<= 1) {
>>> -		fd = __vm_create_guest_memfd(vm, page_size, flag);
>>> +		test_vm_with_gmem_flag(vm, flag, flag & expected_valid_flags);
>>>   
>>> -		if (flag & expected_valid_flags) {
>>> -			TEST_ASSERT(fd > 0,
>>> -				    "guest_memfd() with flag '0x%lx' should be valid",
>>> -				    flag);
>>> -			close(fd);
>>> -		} else {
>>> -			TEST_ASSERT(fd == -1 && errno == EINVAL,
>>> -				    "guest_memfd() with flag '0x%lx' should fail with EINVAL",
>>> -				    flag);
>>> +		if (flag == GUEST_MEMFD_FLAG_SUPPORT_SHARED) {
>>> +			test_vm_with_gmem_flag(
>>> +				vm, flag | GUEST_MEMFD_FLAG_INIT_PRIVATE, true);
>> I don't understand the point of this check.  In 2/51 we set
>> GUEST_MEMFD_FLAG_INIT_PRIVATE when GUEST_MEMFD_FLAG_SUPPORT_SHARED is set.
>>
>> When can this check ever fail?
>>
>> Ira
> In 02/51, GUEST_MEMFD_FLAG_INIT_PRIVATE is not set by default,
> GUEST_MEMFD_FLAG_INIT_PRIVATE is set as one of the valid_flags.
>
> The intention is that GUEST_MEMFD_FLAG_INIT_PRIVATE is only valid if
> GUEST_MEMFD_FLAG_SUPPORT_SHARED is requested by userspace.
>
> In this test, the earlier part before the if block calls
> test_vm_with_gmem_flag() all valid flags, and that already tests
> GUEST_MEMFD_FLAG_SUPPORT_SHARED individually.
>
> Specifically if GUEST_MEMFD_FLAG_SUPPORT_SHARED is set, this if block
> adds a test for when both GUEST_MEMFD_FLAG_SUPPORT_SHARED and
> GUEST_MEMFD_FLAG_INIT_PRIVATE are set, and sets that expect_valid is
> true.
Maybe it's more clear to move this case out of the loop?


>
> This second test doesn't fail, it is meant to check that the kernel
> allows the pair of flags to be set. Hope that makes sense.


