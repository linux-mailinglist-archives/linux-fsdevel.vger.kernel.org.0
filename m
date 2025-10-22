Return-Path: <linux-fsdevel+bounces-65194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7F2BFD64D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 18:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E4D80358A55
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5685827E7F0;
	Wed, 22 Oct 2025 16:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OX80Dl0z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683B335B138
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 16:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761151914; cv=none; b=W67OxdAZDC6DQ5/Fm+A/5DMCtAsahbU+E9MNW4DdUDuX0oftiTF6mQ2Rn11FImE71QPcHoWB5yqkQiZJtsqEDTtWsxvN+9upVf/WbZ+BkLXxWicd+XgYtSjg+2Kqj+l027jrEAoXXu/hYbaiYC095rafNJIMZux1rUS78duCehY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761151914; c=relaxed/simple;
	bh=ZA7nje4u8+QZXJw4GXGWPqWw+cfk8JcJt8Wa4NE0azQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GHQm1ddz/lDXb/ATuHhfjklgevAifx+pjss6MqZ/hBLPgMgIh5ILQ1otBbg4w5I3MHj3tW+p74r/Hj5gw0rvV9mUWe8bUE0EqFtTy5Vhsw9VBl/00tC5kHZxNfqd1lTKem/Pd+6IhT8143u9TdHkBxZcP4B2DSQ4JlPriYIu7Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OX80Dl0z; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3324538ceb0so12109604a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 09:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761151912; x=1761756712; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lR6q3Jz4wEvNB1U/dBjL6AFCbuh1MpNj7/+QxukudLk=;
        b=OX80Dl0zMNbTeDU0khi460DytX3OSC7bH/euG7VzjpUCZZAEs+rRgY24UErx2lSctW
         soZ0k8yooG2GLEbc1lAKaKlRbnwtkZMQShD9iq4L4xf6dDeg/D2qXfwscFu6z4B5k4/I
         tWqrsKPznnq1XUXwWnqAiltb4pV3KfhayqiF5R/DaPlwN9BlRm9F0bDYWedT2UR2F2dH
         8FwIMcYwYiNe0afWV8CvlVh9NKSNuV/zwuSa0v8xW4Mbnn6UpWmM65cTJAwFR1MHDa+T
         QWOyBZLYt6NYNT8ZDzkWOT8NfqdgCAw8GHR56qF/IsWjOABCvcRKnpdrofEcwoqRXGHF
         d32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761151912; x=1761756712;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lR6q3Jz4wEvNB1U/dBjL6AFCbuh1MpNj7/+QxukudLk=;
        b=sx/JyrRQuwznKodLL+KgRwMkBH5Mzb4kW8SQLo8doNOrexBsJ2w8vGeu7UUANK00op
         HGfhqTMxsFAWALcjHHiZ9TQJ1hPHq2febFEwMEN4SQ0q5382iQ2ehpdOaTgQGAYA7be7
         i1nBJ1FS1e2vW2emtFKruclo/HbyQprpCcgrF5TnzalKinW5xQB4e/JmcZ5f3oq7ACZ5
         N5YLc5EOEDt+FhoF2slSYj7WmZzseXrixkFCdgIG/516WntQxtslMUJ/A2zYYjXgelaG
         9Wu9u4KPcwTwCvwaa82LiYf6pLFN1JuPA2ZGHgRpU+sSjDV1fpmAZUOGzyJo3O+7FmK/
         zXMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqQHB4yeMk2hME9NuposlHELoBQ7PG6uJvfeQHMUQ1boqWl7DJsaf1shLnWnyhUh8dHNIrvVlLFA+ru3CB@vger.kernel.org
X-Gm-Message-State: AOJu0YzEEBo/snyRDjZG8og1r9Z9tQx9EeaaYu15/7+RHgUNnf1AZLIx
	UdyI0Zj6GqqWyOHZBJTO6D+665AOUExSA62cZTKVDkO4cy0b9UBFoAibEUxIoPaDfsra4tKCzxx
	1H2WEcTT9vpDPa0dW5j37Yjnq8Q==
X-Google-Smtp-Source: AGHT+IGwxAeNTPtzLvu/Zk8STiamMAryG8fKxvXZatC28J4mfBlAiSQlIt+hBpVpayKRInn/obOZc8kpR+KnyIdqIw==
X-Received: from pjbiq12.prod.google.com ([2002:a17:90a:fb4c:b0:32b:ae4c:196c])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2d8b:b0:32e:23fe:fa51 with SMTP id 98e67ed59e1d1-33bcf867404mr28930141a91.9.1761151911659;
 Wed, 22 Oct 2025 09:51:51 -0700 (PDT)
Date: Wed, 22 Oct 2025 09:51:49 -0700
In-Reply-To: <2457cb3b-5dde-4ca1-b75d-174b5daee28a@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com> <8ee16fbf254115b0fd72cc2b5c06d2ccef66eca9.1760731772.git.ackerleytng@google.com>
 <2457cb3b-5dde-4ca1-b75d-174b5daee28a@arm.com>
Message-ID: <diqz4irqg9qy.fsf@google.com>
Subject: Re: [RFC PATCH v1 07/37] KVM: Introduce KVM_SET_MEMORY_ATTRIBUTES2
From: Ackerley Tng <ackerleytng@google.com>
To: Steven Price <steven.price@arm.com>, cgroups@vger.kernel.org, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, x86@kernel.org
Cc: akpm@linux-foundation.org, binbin.wu@linux.intel.com, bp@alien8.de, 
	brauner@kernel.org, chao.p.peng@intel.com, chenhuacai@kernel.org, 
	corbet@lwn.net, dave.hansen@intel.com, dave.hansen@linux.intel.com, 
	david@redhat.com, dmatlack@google.com, erdemaktas@google.com, 
	fan.du@intel.com, fvdl@google.com, haibo1.xu@intel.com, hannes@cmpxchg.org, 
	hch@infradead.org, hpa@zytor.com, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com, 
	jroedel@suse.de, jthoughton@google.com, jun.miao@intel.com, 
	kai.huang@intel.com, keirf@google.com, kent.overstreet@linux.dev, 
	liam.merwick@oracle.com, maciej.wieczor-retman@intel.com, 
	mail@maciej.szmigiero.name, maobibo@loongson.cn, 
	mathieu.desnoyers@efficios.com, maz@kernel.org, mhiramat@kernel.org, 
	mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com, mingo@redhat.com, 
	mlevitsk@redhat.com, mpe@ellerman.id.au, muchun.song@linux.dev, 
	nikunj@amd.com, nsaenz@amazon.es, oliver.upton@linux.dev, palmer@dabbelt.com, 
	pankaj.gupta@amd.com, paul.walmsley@sifive.com, pbonzini@redhat.com, 
	peterx@redhat.com, pgonda@google.com, prsampat@amd.com, pvorel@suse.cz, 
	qperret@google.com, richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, rostedt@goodmis.org, roypat@amazon.co.uk, 
	rppt@kernel.org, seanjc@google.com, shakeel.butt@linux.dev, shuah@kernel.org, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	tglx@linutronix.de, thomas.lendacky@amd.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, wyihan@google.com, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

Steven Price <steven.price@arm.com> writes:

> On 17/10/2025 21:11, Ackerley Tng wrote:
>> 
>> [...snip...]
>> 
>> @@ -5366,15 +5375,35 @@ static long kvm_vm_ioctl(struct file *filp,
>>  	}
>>  #endif /* CONFIG_HAVE_KVM_IRQ_ROUTING */
>>  #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
>> +	case KVM_SET_MEMORY_ATTRIBUTES2:
>>  	case KVM_SET_MEMORY_ATTRIBUTES: {
>> -		struct kvm_memory_attributes attrs;
>> +		struct kvm_memory_attributes2 attrs;
>> +		unsigned long size;
>> +
>> +		if (ioctl == KVM_SET_MEMORY_ATTRIBUTES) {
>> +			/*
>> +			 * Fields beyond struct kvm_userspace_memory_region shouldn't be
>> +			 * accessed, but avoid leaking kernel memory in case of a bug.
>> +			 */
>> +			memset(&mem, 0, sizeof(mem));
>
> s/mem/attrs/g
>
>> +			size = sizeof(struct kvm_set_memory_attributes);
>> +		} else {
>> +			size = sizeof(struct kvm_set_memory_attributes2);
>
> s/kvm_set_memory_attributes/kvm_memory_attributes/ (on both sizeof lines
> above and in the SANITY_CHECK_MEMORY_ATTRIBUTES_FIELD macro).
>
>> +		}
>> +
>> +		/* Ensure the common parts of the two structs are identical. */
>> +		SANITY_CHECK_MEMORY_ATTRIBUTES_FIELD(slot);
>> +		SANITY_CHECK_MEMORY_ATTRIBUTES_FIELD(flags);
>> +		SANITY_CHECK_MEMORY_ATTRIBUTES_FIELD(guest_phys_addr);
>> +		SANITY_CHECK_MEMORY_ATTRIBUTES_FIELD(memory_size);
>> +		SANITY_CHECK_MEMORY_ATTRIBUTES_FIELD(userspace_addr);
>
> The fields are:
>   * address
>   * size
>   * attributes
>   * flags
>
> The list you've got appears to match struct kvm_userspace_memory_region
> - copy/paste error?
>

Yes I did copy/paste this from KVM_SET_USER_MEMORY_REGION2.

Thanks for catching this! I missed out build-testing this with
CONFIG_KVM_VM_MEMORY_ATTRIBUTES.

I've done that and here's a replacement patch.

> Thanks,
> Steve
>
>> 
>> [...snip...]
>> 

From 31283972574bde2ffa1960d30c80286f8467c594 Mon Sep 17 00:00:00 2001
From: Ackerley Tng <ackerleytng@google.com>
Date: Thu, 16 Oct 2025 11:48:01 -0700
Subject: [PATCH] KVM: Introduce KVM_SET_MEMORY_ATTRIBUTES2

Introduce a "version 2" of KVM_SET_MEMORY_ATTRIBUTES to support returning
information back to userspace.

This new ioctl and structure will, in a later patch, be shared as a
guest_memfd ioctl, where the padding in the new kvm_memory_attributes2
structure will be for writing the response from the guest_memfd ioctl to
userspace.

A new ioctl is necessary for these reasons:

1. KVM_SET_MEMORY_ATTRIBUTES is currently a write-only ioctl and does not
   allow userspace to read fields. There's nothing in code (yet?) that
   validates this, but using _IOWR for consistency would be prudent.

2. KVM_SET_MEMORY_ATTRIBUTES, when used as a guest_memfd ioctl, will need
   an additional field to provide userspace with more error details.

Alternatively, a completely new ioctl could be defined, unrelated to
KVM_SET_MEMORY_ATTRIBUTES, but using the same ioctl number and struct for
the vm and guest_memfd ioctls streamlines the interface for userspace. In
addition, any memory attributes, implemented on the vm or guest_memfd
ioctl, can be easily shared with the other.

Suggested-by: Sean Christopherson <seanjc@google.com>
Change-Id: I50cd506d9a28bf68a90e659015603de579569bc1
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 Documentation/virt/kvm/api.rst | 32 ++++++++++++++++++++++++++++++++
 include/uapi/linux/kvm.h       | 12 ++++++++++++
 virt/kvm/kvm_main.c            | 34 +++++++++++++++++++++++++++++++---
 3 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 754b662a453c3..a812769d79bf6 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6355,6 +6355,8 @@ S390:
 Returns -EINVAL if the VM has the KVM_VM_S390_UCONTROL flag set.
 Returns -EINVAL if called on a protected VM.
 
+.. _KVM_SET_MEMORY_ATTRIBUTES:
+
 4.141 KVM_SET_MEMORY_ATTRIBUTES
 -------------------------------
 
@@ -6512,6 +6514,36 @@ the capability to be present.
 
 `flags` must currently be zero.
 
+4.144 KVM_SET_MEMORY_ATTRIBUTES2
+---------------------------------
+
+:Capability: KVM_CAP_MEMORY_ATTRIBUTES2
+:Architectures: x86
+:Type: vm ioctl
+:Parameters: struct kvm_memory_attributes2 (in/out)
+:Returns: 0 on success, <0 on error
+
+KVM_SET_MEMORY_ATTRIBUTES2 is an extension to
+KVM_SET_MEMORY_ATTRIBUTES that supports returning (writing) values to
+userspace.  The original (pre-extension) fields are shared with
+KVM_SET_MEMORY_ATTRIBUTES identically.
+
+Attribute values are shared with KVM_SET_MEMORY_ATTRIBUTES.
+
+::
+
+  struct kvm_memory_attributes2 {
+	__u64 address;
+	__u64 size;
+	__u64 attributes;
+	__u64 flags;
+	__u64 reserved[4];
+  };
+
+  #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
+
+See also: :ref: `KVM_SET_MEMORY_ATTRIBUTES`.
+
 
 .. _kvm_run:
 
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 52f6000ab0208..c300e38c7c9cd 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -963,6 +963,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_RISCV_MP_STATE_RESET 242
 #define KVM_CAP_ARM_CACHEABLE_PFNMAP_SUPPORTED 243
 #define KVM_CAP_GUEST_MEMFD_FLAGS 244
+#define KVM_CAP_MEMORY_ATTRIBUTES2 245
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
@@ -1617,4 +1618,15 @@ struct kvm_pre_fault_memory {
 	__u64 padding[5];
 };
 
+/* Available with KVM_CAP_MEMORY_ATTRIBUTES2 */
+#define KVM_SET_MEMORY_ATTRIBUTES2              _IOWR(KVMIO,  0xd6, struct kvm_memory_attributes2)
+
+struct kvm_memory_attributes2 {
+	__u64 address;
+	__u64 size;
+	__u64 attributes;
+	__u64 flags;
+	__u64 reserved[4];
+};
+
 #endif /* __LINUX_KVM_H */
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 35166754a22b4..95aa51b334a70 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2621,7 +2621,7 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 	return r;
 }
 static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
-					   struct kvm_memory_attributes *attrs)
+					   struct kvm_memory_attributes2 *attrs)
 {
 	gfn_t start, end;
 
@@ -4959,6 +4959,7 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 	case KVM_CAP_DEVICE_CTRL:
 		return 1;
 #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
+	case KVM_CAP_MEMORY_ATTRIBUTES2:
 	case KVM_CAP_MEMORY_ATTRIBUTES:
 		if (!vm_memory_attributes)
 			return 0;
@@ -5184,6 +5185,14 @@ do {										\
 		     sizeof_field(struct kvm_userspace_memory_region2, field));	\
 } while (0)
 
+#define SANITY_CHECK_MEMORY_ATTRIBUTES_FIELD(field)				\
+do {										\
+	BUILD_BUG_ON(offsetof(struct kvm_memory_attributes, field) !=		\
+		     offsetof(struct kvm_memory_attributes2, field));		\
+	BUILD_BUG_ON(sizeof_field(struct kvm_memory_attributes, field) !=	\
+		     sizeof_field(struct kvm_memory_attributes2, field));	\
+} while (0)
+
 static long kvm_vm_ioctl(struct file *filp,
 			   unsigned int ioctl, unsigned long arg)
 {
@@ -5366,15 +5375,34 @@ static long kvm_vm_ioctl(struct file *filp,
 	}
 #endif /* CONFIG_HAVE_KVM_IRQ_ROUTING */
 #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
+	case KVM_SET_MEMORY_ATTRIBUTES2:
 	case KVM_SET_MEMORY_ATTRIBUTES: {
-		struct kvm_memory_attributes attrs;
+		struct kvm_memory_attributes2 attrs;
+		unsigned long size;
+
+		if (ioctl == KVM_SET_MEMORY_ATTRIBUTES) {
+			/*
+			 * Fields beyond struct kvm_userspace_memory_region shouldn't be
+			 * accessed, but avoid leaking kernel memory in case of a bug.
+			 */
+			memset(&attrs, 0, sizeof(attrs));
+			size = sizeof(struct kvm_memory_attributes);
+		} else {
+			size = sizeof(struct kvm_memory_attributes2);
+		}
+
+		/* Ensure the common parts of the two structs are identical. */
+		SANITY_CHECK_MEMORY_ATTRIBUTES_FIELD(address);
+		SANITY_CHECK_MEMORY_ATTRIBUTES_FIELD(size);
+		SANITY_CHECK_MEMORY_ATTRIBUTES_FIELD(attributes);
+		SANITY_CHECK_MEMORY_ATTRIBUTES_FIELD(flags);
 
 		r = -ENOTTY;
 		if (!vm_memory_attributes)
 			goto out;
 
 		r = -EFAULT;
-		if (copy_from_user(&attrs, argp, sizeof(attrs)))
+		if (copy_from_user(&attrs, argp, size))
 			goto out;
 
 		r = kvm_vm_ioctl_set_mem_attributes(kvm, &attrs);
-- 
2.51.0.915.g61a8936c21-goog


