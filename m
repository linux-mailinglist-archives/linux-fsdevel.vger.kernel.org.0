Return-Path: <linux-fsdevel+bounces-65523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BB4C06BBA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 16:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2DF2A4F963E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 14:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCB331B123;
	Fri, 24 Oct 2025 14:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NzUE2Kho"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780F031C58E
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 14:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761316616; cv=none; b=p7JjFPr0m4kBR6bwzKPi1+6q5ip0ciOgmm49fP5KzSMJe6merGwOChX24vXks6msHcUiCp++ZJrR3hHcxvdIM5DmbGJZoivgbEZ35I5dvcwEYhx2qnXQJE0Z6Cbi0ZTAWj6a9kAGKk1ih24T3A5j/3ROp/IZs2zHEWUGBNQhB6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761316616; c=relaxed/simple;
	bh=7POTLgOQMSvDxIjq1wqPOOdPmObt8KgLrizCHzkYhn0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lFHEdMN9TUmyhQTib3f0GgsLNy8C2TRsspAwy9+krmaUgwD+RBdnLy52MYd2TY/6s2muqC3SfKjIQgEfgKFFlXRhZK7hwfHw3hwk0qj6X1/gxHcfPjymhG3QiGfIz39L+vhSeDkeqY4vlb9JLpkIzyzMp4m4XKiNPqZoAK0u6KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NzUE2Kho; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-277f0ea6ee6so19593345ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 07:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761316613; x=1761921413; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8gWpJOPikpazVbpXRSUPMCcvrbTBk5c7sNdJD5ZAL5c=;
        b=NzUE2KhoZT5V5kdKtycXC9R1Fuz0Hx29g1grTRgIjXtB177CDj8nMuUAgHj9kjaxNr
         G3JwE/y0PQKtHQYH82LtGaPK8mTcehGWsD9AM50JALlHjyoV6T62oo5dqrHFkgD/dqjQ
         iEnwcRmqPAF4gYf7wx3Pl1FHU2UZrwLlpjmBdB+Sz7Gb4hNLIbzQw33jGWenem1G08XI
         PVp8UBbwPpBUaM/WvrTZAx2kg/eWAqah0RbIhQUtudaiNouX/yeMtftBKY6eXmo3oWuZ
         tm/QDQo0ew//6Q4TfJyGeUPm3hTEEIIiGDGAM0nUif4XPvZxQp0AYBj2Rirjp3LWwRRB
         mY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761316613; x=1761921413;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8gWpJOPikpazVbpXRSUPMCcvrbTBk5c7sNdJD5ZAL5c=;
        b=JA115uri0i9CIjPu0LkXDrwhqRVkJ/UNib7r0PSH/BvEI3OFmW2uCOllhj5StCxU09
         /t0RBgg8ME6qKvCsYYFwyYdE6ks18KPA15V0yE99W6enx7VCIOg0U0p7N+pMCMrBaSwg
         LcY6m2AzfWl7MOo356D+kuuOaGdojNwaWO9jtsJqwVktQ31zN0cm1vdLBADQYw2dX/4w
         ZbVUqAZx6xZm6vWVaXd8o9PyU5aNZrxKLINjDaf1TRdxbSTlX5Owp489ONxIjxMt7SRl
         4AtcHqDJwhfl4REOLxw1XZ/ndWa9zD6eevskDjTWk+cfuRhghy31IvpN57NWANJencEf
         Zc1w==
X-Forwarded-Encrypted: i=1; AJvYcCUjMG8u+R7i5oeDOcF2w2Dg97XZH18ma/7j1UdV0NIQAgP/EmaHkeP4zDdADU0+YdAi5z4tW9IaQaAIqnBI@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Hwgf2sCN7DQn3980rJxFRF+lrFZv3ZCInTk2ATY6uu4Zc5AA
	34MFVi4UBE1kicARtrcRxk4SEqvAmfxyo5I/ZL7ySxeAIU1MdwfatFgsyAUMu4lYyNBnyJQ2QqZ
	fqYY11/2078FRY4BjtsH/Vb3AJA==
X-Google-Smtp-Source: AGHT+IHpZZ9f9FI2oIDKJuatT8tIt0u+E9sskkPVtdG8cewdd4WM+aJNDiUGBZhPHxdPQPN/WAuNAtpnF8qjPR3V7w==
X-Received: from plcq12.prod.google.com ([2002:a17:902:e30c:b0:290:28e2:ce4e])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f68c:b0:290:91d2:9304 with SMTP id d9443c01a7336-290c9c8a770mr324316695ad.4.1761316613376;
 Fri, 24 Oct 2025 07:36:53 -0700 (PDT)
Date: Fri, 24 Oct 2025 07:36:51 -0700
In-Reply-To: <aPpEPZ4YfrRHIkal@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com> <8ee16fbf254115b0fd72cc2b5c06d2ccef66eca9.1760731772.git.ackerleytng@google.com>
 <2457cb3b-5dde-4ca1-b75d-174b5daee28a@arm.com> <diqz4irqg9qy.fsf@google.com>
 <diqzy0p2eet3.fsf@google.com> <aPlpKbHGea90IebS@google.com>
 <diqzv7k5emza.fsf@google.com> <aPpEPZ4YfrRHIkal@google.com>
Message-ID: <diqzqzuse58c.fsf@google.com>
Subject: Re: [RFC PATCH v1 07/37] KVM: Introduce KVM_SET_MEMORY_ATTRIBUTES2
From: Ackerley Tng <ackerleytng@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Steven Price <steven.price@arm.com>, cgroups@vger.kernel.org, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	akpm@linux-foundation.org, binbin.wu@linux.intel.com, bp@alien8.de, 
	brauner@kernel.org, chao.p.peng@intel.com, chenhuacai@kernel.org, 
	corbet@lwn.net, dave.hansen@intel.com, dave.hansen@linux.intel.com, 
	david@redhat.com, dmatlack@google.com, erdemaktas@google.com, 
	fan.du@intel.com, fvdl@google.com, haibo1.xu@intel.com, hannes@cmpxchg.org, 
	hch@infradead.org, hpa@zytor.com, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com, 
	jthoughton@google.com, jun.miao@intel.com, kai.huang@intel.com, 
	keirf@google.com, kent.overstreet@linux.dev, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, 
	maobibo@loongson.cn, mathieu.desnoyers@efficios.com, maz@kernel.org, 
	mhiramat@kernel.org, mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com, 
	mingo@redhat.com, mlevitsk@redhat.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, peterx@redhat.com, 
	pgonda@google.com, prsampat@amd.com, pvorel@suse.cz, qperret@google.com, 
	richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, roypat@amazon.co.uk, rppt@kernel.org, 
	shakeel.butt@linux.dev, shuah@kernel.org, suzuki.poulose@arm.com, 
	tabba@google.com, tglx@linutronix.de, thomas.lendacky@amd.com, 
	vannapurve@google.com, vbabka@suse.cz, viro@zeniv.linux.org.uk, 
	vkuznets@redhat.com, will@kernel.org, willy@infradead.org, wyihan@google.com, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Thu, Oct 23, 2025, Ackerley Tng wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>> 
>> > On Wed, Oct 22, 2025, Ackerley Tng wrote:
>> >> Ackerley Tng <ackerleytng@google.com> writes:
>> >> 
>> >> Found another issue with KVM_CAP_MEMORY_ATTRIBUTES2.
>> >> 
>> >> KVM_CAP_MEMORY_ATTRIBUTES2 was defined to do the same thing as
>> >> KVM_CAP_MEMORY_ATTRIBUTES, but that's wrong since
>> >> KVM_CAP_MEMORY_ATTRIBUTES2 should indicate the presence of
>> >> KVM_SET_MEMORY_ATTRIBUTES2 and struct kvm_memory_attributes2.
>> >
>> > No?  If no attributes are supported, whether or not KVM_SET_MEMORY_ATTRIBUTES2
>> > exists is largely irrelevant.
>> 
>> That's true.
>> 
>> > We can even provide the same -ENOTTY errno by
>> > checking that _any_ attributes are supported, i.e. so that doing
>> > KVM_SET_MEMORY_ATTRIBUTES2 on KVM without any support whatsoever fails in the
>> > same way that KVM with code support but no attributes fails.
>> 
>> IIUC KVM_SET_MEMORY_ATTRIBUTES doesn't fail with -ENOTTY now when there
>> are no valid attributes.
>> 
>> Even if there's no valid attributes (as in
>> kvm_supported_mem_attributes() returns 0), it's possible to call
>> KVM_SET_MEMORY_ATTRIBUTES with .attributes set to 0, which will be a
>> no-op, but will return 0.
>> 
>> I think this is kind of correct behavior since .attributes = 0 is
>> actually a valid expression for "I want this range to be shared", and
>> for a VM that doesn't support private memory, it's a valid expression.
>> 
>> 
>> The other way that there are "no attributes" would be if there are no
>> /VM/ attributes, in which case KVM_SET_MEMORY_ATTRIBUTES, sent to as a
>> vm ioctl, will return -ENOTTY.
>
> Ya, this is what I was trying to say with "_any_ attributes are supported".  I.e.
> by "any" I meant "any attributes in KVM for VMs vs. gmems", not "any attributes
> for this specific VM/gmem instance".
>
>> 
>> [...snip...]
>> 

I've been thinking more about this:

  #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
  	case KVM_CAP_MEMORY_ATTRIBUTES2:
  	case KVM_CAP_MEMORY_ATTRIBUTES:
  		if (!vm_memory_attributes)
  			return 0;
  
  		return kvm_supported_mem_attributes(kvm);
  #endif

And the purpose of adding KVM_CAP_MEMORY_ATTRIBUTES2 is that
KVM_CAP_MEMORY_ATTRIBUTES2 tells userspace that
KVM_SET_MEMORY_ATTRIBUTES2 is available iff there are valid
attributes.

(So there's still a purpose)

Without valid attributes, userspace can't tell if it should use
KVM_SET_MEMORY_ATTRIBUTES or the 2 version.

I also added KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES, which tells
userspace the valid attributes when calling KVM_SET_MEMORY_ATTRIBUTES2
on a guest_memfd:

  #ifdef CONFIG_KVM_GUEST_MEMFD
  	case KVM_CAP_GUEST_MEMFD:
  		return 1;
  	case KVM_CAP_GUEST_MEMFD_FLAGS:
  		return kvm_gmem_get_supported_flags(kvm);
  	case KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES:
  		if (vm_memory_attributes)
  			return 0;
  
  		return kvm_supported_mem_attributes(kvm);
  #endif
  
So to set memory attributes, userspace should

  if (kvm_check_cap(KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES) > 0)
	use KVM_SET_MEMORY_ATTRIBUTES2 with guest_memfd
  else if (kvm_check_cap(KVM_CAP_MEMORY_ATTRIBUTES2) > 0)
        use KVM_SET_MEMORY_ATTRIBUTES2 with VM fd
  else if (kvm_check_cap(KVM_CAP_MEMORY_ATTRIBUTES) > 0)
	use KVM_SET_MEMORY_ATTRIBUTES with VM fd
  else
	can't set memory attributes

Something like that?


In selftests there's this, when KVM_SET_USER_MEMORY_REGION2 was
introduced:

  #define TEST_REQUIRE_SET_USER_MEMORY_REGION2()			\
	__TEST_REQUIRE(kvm_has_cap(KVM_CAP_USER_MEMORY2),	\
		       "KVM selftests now require KVM_SET_USER_MEMORY_REGION2 (introduced in v6.8)")

But looks like there's no direct equivalent for the introduction of
KVM_SET_MEMORY_ATTRIBUTES2?

The closest would be to add a TEST_REQUIRE_VALID_ATTRIBUTES() which
checks KVM_CAP_MEMORY_ATTRIBUTES2 or
KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES before making the vm or
guest_memfd ioctl respsectively.

