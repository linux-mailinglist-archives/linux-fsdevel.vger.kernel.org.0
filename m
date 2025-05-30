Return-Path: <linux-fsdevel+bounces-50242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F59AC9640
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 21:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EBEA5059B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 19:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529E727AC30;
	Fri, 30 May 2025 19:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F9D/kUeg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3493523ED69
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 19:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748635182; cv=none; b=ncWmbf6xn3ub9Yo70XHCF2Zkzzm+9nO06kJ3eoVcwGTDJf7PgDhXZgiO5BO+KzqpH8QypMl/houRZAjui6ZVA83NZJY0WNWmvWg4mj1w86v7EN0YzM/sLKVTBV+8h2MPaVodxt+9OoEuN4q7FOPH6JyYC6tO1U2ePOyljKseOaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748635182; c=relaxed/simple;
	bh=tgIdWJfTfE8Hk6gr53VjRErzclr/ehhtTPonwVJQzZU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=poWBLJXeeKBlJiMUKDlkIhsBMrS2jYSC39v7l+YkR+gSAFYp0cVcxGhdFEo+IRbEFJ1lL1MP5RvGS4M4ZpcTviOgyxeh9Xc0P4lBYUFkz3LllJZMz7+OnQ4O/t2VUS2DpPXcZ3x1CZQfLQ9P8dSEddIPB9Cg2MNUoLdpAWj4xzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F9D/kUeg; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-747cebffd4eso141037b3a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 12:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748635180; x=1749239980; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XLJX3ZuweedNmIpG0KUncbRpuBe5C8PWGGVckjGFyc8=;
        b=F9D/kUegV8910/prF+INDnPe8c9BE1061VP7JvND8IZpyP0j+8uTXEAO0Nxb8+C0OM
         1bzfLxSxsy3sywmTxDWyi8Dfxq5wbWiUkFjX5tJtzzR8lFT6uEetwcNT9RTLmo+nAo2x
         YcLCv1OQIfuG83Fo23vs7Q9in8TIUcTlBXuGP+Uqiex5LT4SX2FuG4951ldNl7fODrBo
         Bz6VhSVWivKGs+0K7voQkP9dxVA7D/0nR1yfeWvOF6U5TTyhiatYHC1ssEC7wpafDa8p
         K1Cx3lYd1nWJEN7RVcqovQKQPo+BFYOqzZToKSvrhUPXuIGocEX4jRFVRLnkHdTsdSmz
         C2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748635180; x=1749239980;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XLJX3ZuweedNmIpG0KUncbRpuBe5C8PWGGVckjGFyc8=;
        b=gf4CSjqtsOCq8kKIWYJg/4nTRYKf9vMW4slUkKFvaRT+x8nlZe99zTQtBzd5DENqUl
         yediZ/k5k/CYKgT4FZX0Bkwn31FY8vO9tmROMHYa08fyEbfG7LGLD+v8a/iFZF5IGgzR
         XkI5o8V7RnFwIayGuYl7eCIZuV6dR1IOUtc4FFTRubIjvlCnc8iyhBYA2rW+676FtbD6
         HrV1G1ICgaFmfWoRJhZRgRr8ORVuO8Bt5QGm24u+WTtCcsi6pmnODcnhOF5w41Wcs99R
         3xEEANH1mhTHB+M3qT6Bc28NegewXAyzPvOLWHx7APzwT1prtJpUSOWv4T1bwZGwdxAt
         ckGQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5tC4PWNjtul63WDeHe3qVFZuTZ+7DsO4ZB8SVabHA3An5zz0hWPdvCc/dibaCPqsdusMkbss3HbREm5J5@vger.kernel.org
X-Gm-Message-State: AOJu0YyGGY371YGGe3hKsff+6LgIqGzrN/ZH0QrsmCxXGWGgn4OCrIMu
	RfDfv+k/6tzkiUV98zceWF4kdjHGqmzggCysojCqzaNDibkKiN7xLeGvv7DUbRa0ddphEFH0z/D
	w+stoPt+40YH431uaa0DhyuNWGw==
X-Google-Smtp-Source: AGHT+IFFhC3hXX+PVrgQzetLdBECprnA1DEgPQOOh2/WyOZiyyWJYJHQsUMyh+zMD4P5Er1nSHhtcou8zoPt2CfFVA==
X-Received: from pfoh25.prod.google.com ([2002:aa7:86d9:0:b0:744:671f:ab5c])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2303:b0:742:ae7e:7da8 with SMTP id d2e1a72fcca58-747bd96e16emr6946361b3a.8.1748635180286;
 Fri, 30 May 2025 12:59:40 -0700 (PDT)
Date: Fri, 30 May 2025 12:59:38 -0700
In-Reply-To: <1c5cfc23-3f63-404d-a4bf-030c24412b20@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <65afac3b13851c442c72652904db6d5755299615.1747264138.git.ackerleytng@google.com>
 <6825f0f3ac8a7_337c392942d@iweiny-mobl.notmuch> <diqzmsbcfo4o.fsf@ackerleytng-ctop.c.googlers.com>
 <1c5cfc23-3f63-404d-a4bf-030c24412b20@linux.intel.com>
Message-ID: <diqzwm9x6f9x.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH v2 03/51] KVM: selftests: Update guest_memfd_test for
 INIT_PRIVATE flag
From: Ackerley Tng <ackerleytng@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>, Ira Weiny <ira.weiny@intel.com>
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
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com, quic_pheragu@quicinc.com, 
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com, richard.weiyang@gmail.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	rppt@kernel.org, seanjc@google.com, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

Binbin Wu <binbin.wu@linux.intel.com> writes:

> On 5/17/2025 1:42 AM, Ackerley Tng wrote:
>> Ira Weiny <ira.weiny@intel.com> writes:
>>
>>> Ackerley Tng wrote:
>>>> Test that GUEST_MEMFD_FLAG_INIT_PRIVATE is only valid when
>>>> GUEST_MEMFD_FLAG_SUPPORT_SHARED is set.
>>>>
>>>> Change-Id: I506e236a232047cfaee17bcaed02ee14c8d25bbb
>>>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>>>> ---
>>>>   .../testing/selftests/kvm/guest_memfd_test.c  | 36 ++++++++++++-------
>>>>   1 file changed, 24 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
>>>> index 60aaba5808a5..bf2876cbd711 100644
>>>> --- a/tools/testing/selftests/kvm/guest_memfd_test.c
>>>> +++ b/tools/testing/selftests/kvm/guest_memfd_test.c
>>>> @@ -401,13 +401,31 @@ static void test_with_type(unsigned long vm_type, uint64_t guest_memfd_flags,
>>>>   	kvm_vm_release(vm);
>>>>   }
>>>>   
>>>> +static void test_vm_with_gmem_flag(struct kvm_vm *vm, uint64_t flag,
>>>> +				   bool expect_valid)
>>>> +{
>>>> +	size_t page_size = getpagesize();
>>>> +	int fd;
>>>> +
>>>> +	fd = __vm_create_guest_memfd(vm, page_size, flag);
>>>> +
>>>> +	if (expect_valid) {
>>>> +		TEST_ASSERT(fd > 0,
>>>> +			    "guest_memfd() with flag '0x%lx' should be valid",
>>>> +			    flag);
>>>> +		close(fd);
>>>> +	} else {
>>>> +		TEST_ASSERT(fd == -1 && errno == EINVAL,
>>>> +			    "guest_memfd() with flag '0x%lx' should fail with EINVAL",
>>>> +			    flag);
>>>> +	}
>>>> +}
>>>> +
>>>>   static void test_vm_type_gmem_flag_validity(unsigned long vm_type,
>>>>   					    uint64_t expected_valid_flags)
>>>>   {
>>>> -	size_t page_size = getpagesize();
>>>>   	struct kvm_vm *vm;
>>>>   	uint64_t flag = 0;
>>>> -	int fd;
>>>>   
>>>>   	if (!(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(vm_type)))
>>>>   		return;
>>>> @@ -415,17 +433,11 @@ static void test_vm_type_gmem_flag_validity(unsigned long vm_type,
>>>>   	vm = vm_create_barebones_type(vm_type);
>>>>   
>>>>   	for (flag = BIT(0); flag; flag <<= 1) {
>>>> -		fd = __vm_create_guest_memfd(vm, page_size, flag);
>>>> +		test_vm_with_gmem_flag(vm, flag, flag & expected_valid_flags);
>>>>   
>>>> -		if (flag & expected_valid_flags) {
>>>> -			TEST_ASSERT(fd > 0,
>>>> -				    "guest_memfd() with flag '0x%lx' should be valid",
>>>> -				    flag);
>>>> -			close(fd);
>>>> -		} else {
>>>> -			TEST_ASSERT(fd == -1 && errno == EINVAL,
>>>> -				    "guest_memfd() with flag '0x%lx' should fail with EINVAL",
>>>> -				    flag);
>>>> +		if (flag == GUEST_MEMFD_FLAG_SUPPORT_SHARED) {
>>>> +			test_vm_with_gmem_flag(
>>>> +				vm, flag | GUEST_MEMFD_FLAG_INIT_PRIVATE, true);
>>> I don't understand the point of this check.  In 2/51 we set
>>> GUEST_MEMFD_FLAG_INIT_PRIVATE when GUEST_MEMFD_FLAG_SUPPORT_SHARED is set.
>>>
>>> When can this check ever fail?
>>>
>>> Ira
>> In 02/51, GUEST_MEMFD_FLAG_INIT_PRIVATE is not set by default,
>> GUEST_MEMFD_FLAG_INIT_PRIVATE is set as one of the valid_flags.
>>
>> The intention is that GUEST_MEMFD_FLAG_INIT_PRIVATE is only valid if
>> GUEST_MEMFD_FLAG_SUPPORT_SHARED is requested by userspace.
>>
>> In this test, the earlier part before the if block calls
>> test_vm_with_gmem_flag() all valid flags, and that already tests
>> GUEST_MEMFD_FLAG_SUPPORT_SHARED individually.
>>
>> Specifically if GUEST_MEMFD_FLAG_SUPPORT_SHARED is set, this if block
>> adds a test for when both GUEST_MEMFD_FLAG_SUPPORT_SHARED and
>> GUEST_MEMFD_FLAG_INIT_PRIVATE are set, and sets that expect_valid is
>> true.
> Maybe it's more clear to move this case out of the loop?
>

Will try that in the next revision. Thanks!

>>
>> This second test doesn't fail, it is meant to check that the kernel
>> allows the pair of flags to be set. Hope that makes sense.

