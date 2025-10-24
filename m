Return-Path: <linux-fsdevel+bounces-65526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EE7C06E0C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 17:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D7371C012B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 15:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD87322DBB;
	Fri, 24 Oct 2025 15:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PdFL9bMR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3061322551
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 15:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761318669; cv=none; b=oHye4EMj4ZT5+8rQQJ0R7Mk5S3P5Y6yEm49eaWWN0m9jkJDoO3d9xsgMdvfNhcG9u0VsRCXmfUl2gj8BWwY0U5CEjdL2w0QS+H+B7+8bBnKSMQ9K7MZvO0Rusq4XUZea238LzJfZNgc8jNh22+Qb+LGHWhlz7dP23miUxXQeljE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761318669; c=relaxed/simple;
	bh=1nO7Q8hQyC3COpeoqfKQV1SPG1bRbzjE5pk6Pr0SPiE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nz3NAygLasVBUtaaFLooTAlItCQscTXLYuKzzGfHE2tLt9fa1V3DsufWZewM89c7QXgpDTPY+PA08ApT2qQT9KA2rqk6g+RTIXNwVrdJkFulrK6DAgpl9Qd4kGKS0uThGDR5TqdjJINPWgJnV7SmIOIMFBCgmEoO2CSfuJ/XLKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PdFL9bMR; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-78104c8c8ddso1754097b3a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Oct 2025 08:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761318667; x=1761923467; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f8S1KonkShBOqtsinZhRSshiH2hzjBvvVn7bRME6LIQ=;
        b=PdFL9bMRdmSav6wHntHEigspAqK5ZQVdmglszN15d48ilcnIRTiudjQWMnmee6O6XX
         SixDILzdJAtbc0M55nkXkuOwd90KpMYbFrwDFzF9JQcm4OwKQHu/HOQo8KqWtjOj1LWr
         1hDZZeTGn4KbT0aGbqDX+Ha7BIRUqKdYXOj9lC32OUAKdmq8//pp+Ao6NdS2b4tperTx
         Ldb0XlNGK5/ze2XdkrR3rxHoXwa/cIx7ZxxsJHUG7eF3exUP/9R9Lm7KwD4FWTLYug6t
         jx6qe+sq3BSS+NLmeXQuUPnmfbsAMTqNFUaGTuhZCCMhIjcsG7FGP8UajYFNhUZv/sbG
         prbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761318667; x=1761923467;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f8S1KonkShBOqtsinZhRSshiH2hzjBvvVn7bRME6LIQ=;
        b=pYVZgMc2YKc9nxUmPjorShLEgv/JaTgfY4jpzz0N7J9B36b9qMZ4lafsvg5S3g5Ukb
         tc5cq0azPLSXjAn2y7/yGUKcPcJDxRYvKa3OFvlDNn0eG8z85OOfsUaQ18TPAMB5WCqZ
         bSqZpccPAz28vs65HPG7PHi+npJgJ7x+Rx9Ep6hnOplmI25Au6Ral+ShpZ6nZ8+RY2jQ
         Z4b8H6DYKgKQGGLz3KUCHWlnOo+sZCPVNUBe8wiSF9Zv1kqBZPjkwJ4+jN7vVZJIB74s
         rBn7smh3I5BzyogNZZbz08mG2QvkYoxbkmD3vQFm9Lqi8JyRvRaVjmzPvD9EEPwbUfMY
         7VLQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9jx7wWsHkFrLu82W3Zb3u2CUWiYYJW9GlW8XhJM2BXHoRyc+UDJ1XjVxa6+Ao7D5kyiZ5bovv0ggBrXGI@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3obaXM8z5TXmofk+FsxrRBQW9eDFL5u1INKk47SBVgJHozVxT
	1n0BAzmnyB2lOeCpo2FOeYH3E2uvHyx0PbcYqCzKBzg86gkv05w29atTO9F2DfF82s0ddG5211n
	H9dtGmg==
X-Google-Smtp-Source: AGHT+IFmiZvDW9+VEv8fXtsDHeyqGJSro010YRSFD/DT0a4vYVNsrLONxsLbwaaV3B5ySTybgRqQQLvhvsY=
X-Received: from pjbgg11.prod.google.com ([2002:a17:90b:a0b:b0:330:b9e9:7acc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a11c:b0:33e:779e:fa7f
 with SMTP id adf61e73a8af0-33e779efbf6mr1848603637.1.1761318666959; Fri, 24
 Oct 2025 08:11:06 -0700 (PDT)
Date: Fri, 24 Oct 2025 08:11:05 -0700
In-Reply-To: <diqzqzuse58c.fsf@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com> <8ee16fbf254115b0fd72cc2b5c06d2ccef66eca9.1760731772.git.ackerleytng@google.com>
 <2457cb3b-5dde-4ca1-b75d-174b5daee28a@arm.com> <diqz4irqg9qy.fsf@google.com>
 <diqzy0p2eet3.fsf@google.com> <aPlpKbHGea90IebS@google.com>
 <diqzv7k5emza.fsf@google.com> <aPpEPZ4YfrRHIkal@google.com> <diqzqzuse58c.fsf@google.com>
Message-ID: <aPuXCV0Aof0zihW9@google.com>
Subject: Re: [RFC PATCH v1 07/37] KVM: Introduce KVM_SET_MEMORY_ATTRIBUTES2
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
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
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 24, 2025, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> >> 
> >> [...snip...]
> >> 
> 
> I've been thinking more about this:
> 
>   #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
>   	case KVM_CAP_MEMORY_ATTRIBUTES2:
>   	case KVM_CAP_MEMORY_ATTRIBUTES:
>   		if (!vm_memory_attributes)
>   			return 0;
>   
>   		return kvm_supported_mem_attributes(kvm);
>   #endif
> 
> And the purpose of adding KVM_CAP_MEMORY_ATTRIBUTES2 is that
> KVM_CAP_MEMORY_ATTRIBUTES2 tells userspace that
> KVM_SET_MEMORY_ATTRIBUTES2 is available iff there are valid
> attributes.
> 
> (So there's still a purpose)
> 
> Without valid attributes, userspace can't tell if it should use
> KVM_SET_MEMORY_ATTRIBUTES or the 2 version.

To do what?  If there are no attributes, userspace can't do anything useful anyways.

> I also added KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES, which tells
> userspace the valid attributes when calling KVM_SET_MEMORY_ATTRIBUTES2
> on a guest_memfd:

Ya, and that KVM_SET_MEMORY_ATTRIBUTES2 is supported on guest_memfd.

>   #ifdef CONFIG_KVM_GUEST_MEMFD
>   	case KVM_CAP_GUEST_MEMFD:
>   		return 1;
>   	case KVM_CAP_GUEST_MEMFD_FLAGS:
>   		return kvm_gmem_get_supported_flags(kvm);
>   	case KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES:
>   		if (vm_memory_attributes)
>   			return 0;
>   
>   		return kvm_supported_mem_attributes(kvm);
>   #endif
>   
> So to set memory attributes, userspace should

Userspace *can*.  User could also decide it only wants to support guest_memfd
attributes, e.g. because the platform admins controls the entire stack and built
their entire operation around in-place conversion.

>   if (kvm_check_cap(KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES) > 0)
> 	use KVM_SET_MEMORY_ATTRIBUTES2 with guest_memfd
>   else if (kvm_check_cap(KVM_CAP_MEMORY_ATTRIBUTES2) > 0)
>         use KVM_SET_MEMORY_ATTRIBUTES2 with VM fd
>   else if (kvm_check_cap(KVM_CAP_MEMORY_ATTRIBUTES) > 0)
> 	use KVM_SET_MEMORY_ATTRIBUTES with VM fd
>   else
> 	can't set memory attributes
> 
> Something like that?

More or else, ya.

> In selftests there's this, when KVM_SET_USER_MEMORY_REGION2 was
> introduced:
> 
>   #define TEST_REQUIRE_SET_USER_MEMORY_REGION2()			\
> 	__TEST_REQUIRE(kvm_has_cap(KVM_CAP_USER_MEMORY2),	\
> 		       "KVM selftests now require KVM_SET_USER_MEMORY_REGION2 (introduced in v6.8)")
> 
> But looks like there's no direct equivalent for the introduction of
> KVM_SET_MEMORY_ATTRIBUTES2?

KVM_CAP_USER_MEMORY2 is the equivalent.

There's was no need to enumerate anything beyond yes/no, because
SET_USER_MEMORY_REGION2 didn't introduce new flags, it expanded the size of the
structure passed in from userspace so that KVM_CAP_GUEST_MEMFD could be introduced
without breaking backwards compatibility.

> The closest would be to add a TEST_REQUIRE_VALID_ATTRIBUTES() which
> checks KVM_CAP_MEMORY_ATTRIBUTES2 or
> KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES before making the vm or
> guest_memfd ioctl respsectively.

Yes.  This is what I did in my (never posted, but functional) version:

@@ -486,6 +488,7 @@ struct kvm_vm *__vm_create(struct vm_shape shape, uint32_t nr_runnable_vcpus,
        }
        guest_rng = new_guest_random_state(guest_random_seed);
        sync_global_to_guest(vm, guest_rng);
+       sync_global_to_guest(vm, kvm_has_gmem_attributes);
 
        kvm_arch_vm_post_create(vm, nr_runnable_vcpus);
 
@@ -2319,6 +2333,8 @@ void __attribute((constructor)) kvm_selftest_init(void)
        guest_random_seed = last_guest_seed = random();
        pr_info("Random seed: 0x%x\n", guest_random_seed);
 
+       kvm_has_gmem_attributes = kvm_has_cap(KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES);
+
        kvm_selftest_arch_init();
 }
 
That way the core library code can pivot on gmem vs. VM attributes without having
to rely on tests to define anything.  E.g.

static inline void vm_mem_set_memory_attributes(struct kvm_vm *vm, uint64_t gpa,
						uint64_t size, uint64_t attrs)
{
	if (kvm_has_gmem_attributes) {
		off_t fd_offset;
		uint64_t len;
		int fd;

		fd = kvm_gpa_to_guest_memfd(vm, gpa, &fd_offset, &len);
		TEST_ASSERT(len >= size, "Setting attributes beyond the length of a guest_memfd");
		gmem_set_memory_attributes(fd, fd_offset, size, attrs);
	} else {
		vm_set_memory_attributes(vm, gpa, size, attrs);
	}
}

