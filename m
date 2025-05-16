Return-Path: <linux-fsdevel+bounces-49286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C346ABA21B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 19:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 514B14E63BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 17:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5D7278758;
	Fri, 16 May 2025 17:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HVWo5UR8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675CC2749C7
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 17:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747417372; cv=none; b=r0r7RPiQA8TnbmF+1ierox7lYO9TVB2cMU+5DA2O50Bq8IV3Y7z7NYC/2AKXS8LbGl+xt4Zy/F7fx+ZSciY+H625d/2Ux7HikB3xyG828J29FUWGqNJKumDOzyLTNRjxhJ1W1QRjJsS6p7m+MQ5XUj8WrxCE4TUinzv3AX2nTrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747417372; c=relaxed/simple;
	bh=/oZWTLboJ1r1HwZnL8ol3rHmbO0GkMBVgO/nSs8EhQA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QYGzB3RG4LWNWOiUnoj3yqKv8l8nSaB8ZU3h6rRalutMQQQewx3JuN60Flmsa0C+vRFrU9J/9gC2NuPbFPsBzvI1TlVwdTvtzrwcKC9P+sf5XGwJyJjuQqDREbjwZuatxtKQmHQxSDg4EzubHKDidoDRR0+HnM6lwmOx8+OL53Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HVWo5UR8; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b26e120e300so1816190a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 May 2025 10:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747417369; x=1748022169; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UHtggF1Xmmx8sunRLPpEo5y2n3Fbz0jNKo8YthXyxlY=;
        b=HVWo5UR8opSBCFI1dc6meoyTzedjbObtgTVC7ltLORi93kHV7ixtoQEMROus9pT0AX
         TyF197cPYWhbksqBQIsqYBZ+0L6mWfDswI4sgOe8UEguzphY3grD5c0wDwmvENLA6Gn1
         fRzhBwSVJn6aJj041vnfaDo/eZde1L7Qlmo9xyj7DU2n5cnaeJ2U/9JpvqHTAMKuWTeq
         YZscX//icFQF0qWHdkjqF+zrRmfHRc9L+iyd6HQUqmZxzwypx4O5zqTwV4osA+wnwZd8
         tljaUaYnsMoFa4EaR5kKIJHuiqwiQ/SFP33dUffo59CoPmm4dJ8GW/dwz6gNp5crU7Ha
         8rWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747417369; x=1748022169;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UHtggF1Xmmx8sunRLPpEo5y2n3Fbz0jNKo8YthXyxlY=;
        b=S0m/nf6tlJcY3xpPDQWzU71yhcwTGQFutlIVHX0laWSZvNNEBT935hDUb1o0uFucOP
         RXw2Wpikm+X0qgT81iDuyVehhBB9ruuh4eEZFO8UVV9sHoSMx6D0QSVQKBEIteZYiXZc
         GCwefKSrHp7J0+YuHfuaHytvC2GfxBIxMxJc44mj6igu91Pz3PPxy1m+gKlFM3rUdxut
         hZh8o3d8sSUnIPQ6b4zAbQW3IcOMQueJJFyHlZ9UA9KQYn7jA8egCurAMftHxKQeIQ8R
         jQlhTk8WT95YVxSe9nkqMnzDkMLoZeWIVhRogAdmLuDZ+oVt83jpIxNfghWFhfLkFLaZ
         Yh7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7e/pPZjoszqArpkdvJ7oT+Uj+INQ6/JICeQKBPjjYK1mnk3tBmdKCpu/3vZWeGAVl6DDVqoyB1DSAhSrV@vger.kernel.org
X-Gm-Message-State: AOJu0YwFQU30R7F5dHQi4wp2S5JucJRUmeAv6GFdJKP9BzNURRmInXGQ
	eYCL+CpfiO8F5g6kFYlTWKHRm3/RFfMfGJHCsOVOHoYYFDomW9+7wJKbepI5pLahudvczRV6V36
	0HFji9/47cnVzWdGIULxd/vuijQ==
X-Google-Smtp-Source: AGHT+IFZZue4eVCNyGlBlVu3FOMYDdiN/+lNxD2W2guGukj7N1aj09nrbw9YDmV/sDzoeyH8oFlR4vBN8C7KtAQknw==
X-Received: from pjyp15.prod.google.com ([2002:a17:90a:e70f:b0:2ef:d283:5089])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4b0f:b0:2fe:b907:562f with SMTP id 98e67ed59e1d1-30e7d527e41mr6797759a91.14.1747417369222;
 Fri, 16 May 2025 10:42:49 -0700 (PDT)
Date: Fri, 16 May 2025 10:42:47 -0700
In-Reply-To: <6825f0f3ac8a7_337c392942d@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <65afac3b13851c442c72652904db6d5755299615.1747264138.git.ackerleytng@google.com>
 <6825f0f3ac8a7_337c392942d@iweiny-mobl.notmuch>
Message-ID: <diqzmsbcfo4o.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH v2 03/51] KVM: selftests: Update guest_memfd_test for
 INIT_PRIVATE flag
From: Ackerley Tng <ackerleytng@google.com>
To: Ira Weiny <ira.weiny@intel.com>, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, x86@kernel.org, linux-fsdevel@vger.kernel.org
Cc: aik@amd.com, ajones@ventanamicro.com, akpm@linux-foundation.org, 
	amoorthy@google.com, anthony.yznaga@oracle.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, bfoster@redhat.com, binbin.wu@linux.intel.com, 
	brauner@kernel.org, catalin.marinas@arm.com, chao.p.peng@intel.com, 
	chenhuacai@kernel.org, dave.hansen@intel.com, david@redhat.com, 
	dmatlack@google.com, dwmw@amazon.co.uk, erdemaktas@google.com, 
	fan.du@intel.com, fvdl@google.com, graf@amazon.com, haibo1.xu@intel.com, 
	hch@infradead.org, hughd@google.com, ira.weiny@intel.com, 
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

Ira Weiny <ira.weiny@intel.com> writes:

> Ackerley Tng wrote:
>> Test that GUEST_MEMFD_FLAG_INIT_PRIVATE is only valid when
>> GUEST_MEMFD_FLAG_SUPPORT_SHARED is set.
>> 
>> Change-Id: I506e236a232047cfaee17bcaed02ee14c8d25bbb
>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>> ---
>>  .../testing/selftests/kvm/guest_memfd_test.c  | 36 ++++++++++++-------
>>  1 file changed, 24 insertions(+), 12 deletions(-)
>> 
>> diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
>> index 60aaba5808a5..bf2876cbd711 100644
>> --- a/tools/testing/selftests/kvm/guest_memfd_test.c
>> +++ b/tools/testing/selftests/kvm/guest_memfd_test.c
>> @@ -401,13 +401,31 @@ static void test_with_type(unsigned long vm_type, uint64_t guest_memfd_flags,
>>  	kvm_vm_release(vm);
>>  }
>>  
>> +static void test_vm_with_gmem_flag(struct kvm_vm *vm, uint64_t flag,
>> +				   bool expect_valid)
>> +{
>> +	size_t page_size = getpagesize();
>> +	int fd;
>> +
>> +	fd = __vm_create_guest_memfd(vm, page_size, flag);
>> +
>> +	if (expect_valid) {
>> +		TEST_ASSERT(fd > 0,
>> +			    "guest_memfd() with flag '0x%lx' should be valid",
>> +			    flag);
>> +		close(fd);
>> +	} else {
>> +		TEST_ASSERT(fd == -1 && errno == EINVAL,
>> +			    "guest_memfd() with flag '0x%lx' should fail with EINVAL",
>> +			    flag);
>> +	}
>> +}
>> +
>>  static void test_vm_type_gmem_flag_validity(unsigned long vm_type,
>>  					    uint64_t expected_valid_flags)
>>  {
>> -	size_t page_size = getpagesize();
>>  	struct kvm_vm *vm;
>>  	uint64_t flag = 0;
>> -	int fd;
>>  
>>  	if (!(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(vm_type)))
>>  		return;
>> @@ -415,17 +433,11 @@ static void test_vm_type_gmem_flag_validity(unsigned long vm_type,
>>  	vm = vm_create_barebones_type(vm_type);
>>  
>>  	for (flag = BIT(0); flag; flag <<= 1) {
>> -		fd = __vm_create_guest_memfd(vm, page_size, flag);
>> +		test_vm_with_gmem_flag(vm, flag, flag & expected_valid_flags);
>>  
>> -		if (flag & expected_valid_flags) {
>> -			TEST_ASSERT(fd > 0,
>> -				    "guest_memfd() with flag '0x%lx' should be valid",
>> -				    flag);
>> -			close(fd);
>> -		} else {
>> -			TEST_ASSERT(fd == -1 && errno == EINVAL,
>> -				    "guest_memfd() with flag '0x%lx' should fail with EINVAL",
>> -				    flag);
>> +		if (flag == GUEST_MEMFD_FLAG_SUPPORT_SHARED) {
>> +			test_vm_with_gmem_flag(
>> +				vm, flag | GUEST_MEMFD_FLAG_INIT_PRIVATE, true);
>
> I don't understand the point of this check.  In 2/51 we set 
> GUEST_MEMFD_FLAG_INIT_PRIVATE when GUEST_MEMFD_FLAG_SUPPORT_SHARED is set.
>
> When can this check ever fail?
>
> Ira

In 02/51, GUEST_MEMFD_FLAG_INIT_PRIVATE is not set by default,
GUEST_MEMFD_FLAG_INIT_PRIVATE is set as one of the valid_flags.

The intention is that GUEST_MEMFD_FLAG_INIT_PRIVATE is only valid if
GUEST_MEMFD_FLAG_SUPPORT_SHARED is requested by userspace.

In this test, the earlier part before the if block calls
test_vm_with_gmem_flag() all valid flags, and that already tests
GUEST_MEMFD_FLAG_SUPPORT_SHARED individually.

Specifically if GUEST_MEMFD_FLAG_SUPPORT_SHARED is set, this if block
adds a test for when both GUEST_MEMFD_FLAG_SUPPORT_SHARED and
GUEST_MEMFD_FLAG_INIT_PRIVATE are set, and sets that expect_valid is
true.

This second test doesn't fail, it is meant to check that the kernel
allows the pair of flags to be set. Hope that makes sense.

