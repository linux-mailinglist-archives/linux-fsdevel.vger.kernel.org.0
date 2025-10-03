Return-Path: <linux-fsdevel+bounces-63376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFF2BB7317
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 16:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E4D319E7E81
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 14:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFAB23D7FA;
	Fri,  3 Oct 2025 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xhCX0EiJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E9C347DD
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 14:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759502121; cv=none; b=I28auM5Yc41H1HCFFyEMHgsRz4aRMr9mf6oKHfnirMvyg9nV8hXqS8nGOYEfZQSOHDikZkJWFhq4e3vYrPLWC+dKrAf5XB8jf3MbHV1tIWxW67VRlsZHTsaA2W5UIWcWrFF2npnmAfHs0P2wmUwisRhT1g3qx/myFIq0fhHr15o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759502121; c=relaxed/simple;
	bh=Q4wvhKK1SLC7lyGyvNT/vgYSM+5FbboY05jYhys6UEU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c/NSw87Jv8Gwv4jPabhZ139Ar5OiG4R/C80rfeFuH+VFismqGDXiwstsHi3CkCSYjUx8QTeLbN0WXjHfB5orn3qwjbgeQosXmC6QPVRjWqHU5azyBrVpA4Jq2LWQGyS01iohOc0sAB2j4W1PVUAYZsXc0oMXGWHdaa9SM1JMstQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xhCX0EiJ; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b57cf8dba28so2146667a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Oct 2025 07:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759502119; x=1760106919; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Iz/kuorGnhS1JOjPWbMWU1uMXuAxZjX5KeqruEHo5gU=;
        b=xhCX0EiJWFYwAOJ9Hx1CL2LrSi4BlAnCg5AMuvjvqS6xZuUsBwXwmKLxgXRgOTiF6r
         W4OXOTn5Y9+HaEghznHKnFZPcaK+Bu65bV+IG6LiryzVzvgotPDM1KYNfRxM5qpYB1lz
         k0FulPSDye9EQQuMwcXTSgHTEolLffJFBsaJn/WZ4JJX7B1tcYlZ8kC18TlP5LpEbWfr
         MxkGAjcwDUXa8SgvxJJ3TUqrZEJyE5OvhMfp1frqyTH5FmvL0OGJyHeACEnEtPQ7FURI
         wj9cbjhtyz8qQPSJk0bYQS9IA12E7q3wcsA1aDG1iKu4lCKkG3W7qRpVal/A1iZS2cB3
         veJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759502119; x=1760106919;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iz/kuorGnhS1JOjPWbMWU1uMXuAxZjX5KeqruEHo5gU=;
        b=NTZHb6HtLn48CHJNp1SqTVudcgWgtBgsF7Lr1c38PZO0N30ReOr/lnJlUkt1hDNPX9
         4QPp36/f9+K5if87gja7HyWoCe7EK+7QuEPIYru9w/GTN3z/O9sRlsRaNBKopiGsVqy9
         HgGpziZQERk+Za5ZqohnHFwsOcdO0stAYjkkIrfd3bDiKI2QVswyHv+ZkFflwOVJ7PrM
         Gyg5q/nVnRH/aQFWl4dsRtSw1zAi/nVyYB17Gj0xyM2TIkshHJ995P2VQVm5g1cigB2d
         IHC3mEI2LJqbD+Hc4byPuec7HtdVHvTx0Bx7r2bTdwztp1Kjew9WnQl452nxSuSCRPrI
         yRtw==
X-Forwarded-Encrypted: i=1; AJvYcCWAoFLAy+dad9lt/CqZyPizImxWeXAQ1sxL+NkDxFCUVa6DLIDCaDTMxcE6flmQA57lA9lzD+yaOvbrDEi0@vger.kernel.org
X-Gm-Message-State: AOJu0YyKcb+dyH6BREv0mQAWqUkQjd9ud227wilcRKQq9WHIhZhrMJ63
	FWCXPOBtl5YPs9/T8KMDiX9ihdiL5JQVaoPOozz46I4i+xx+xt0+WsmmcPROxk3TZ0mUEg7o3Rb
	eF4ZpLg==
X-Google-Smtp-Source: AGHT+IFUN7Oe4z6ZymRlBXqr3L4kG4PYp2PMFWWKwKk/eG/6YDVO+WPrjEYPY3MOxRYFU3HuhZBFs27G7uM=
X-Received: from pjpy4.prod.google.com ([2002:a17:90a:a404:b0:32b:95bb:dbc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a11:b0:32e:e18a:3691
 with SMTP id 98e67ed59e1d1-339c27b3cf0mr3856927a91.35.1759502118454; Fri, 03
 Oct 2025 07:35:18 -0700 (PDT)
Date: Fri, 3 Oct 2025 07:35:16 -0700
In-Reply-To: <b3c2da681c5bf139e2eaf0ea82c7422f972f6288.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com> <b3c2da681c5bf139e2eaf0ea82c7422f972f6288.1747264138.git.ackerleytng@google.com>
Message-ID: <aN_fJEZXo6wkcHOh@google.com>
Subject: Re: [RFC PATCH v2 29/51] mm: guestmem_hugetlb: Wrap HugeTLB as an
 allocator for guest_memfd
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-fsdevel@vger.kernel.org, aik@amd.com, 
	ajones@ventanamicro.com, akpm@linux-foundation.org, amoorthy@google.com, 
	anthony.yznaga@oracle.com, anup@brainfault.org, aou@eecs.berkeley.edu, 
	bfoster@redhat.com, binbin.wu@linux.intel.com, brauner@kernel.org, 
	catalin.marinas@arm.com, chao.p.peng@intel.com, chenhuacai@kernel.org, 
	dave.hansen@intel.com, david@redhat.com, dmatlack@google.com, 
	dwmw@amazon.co.uk, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	graf@amazon.com, haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, 
	ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, 
	jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com, 
	jun.miao@intel.com, kai.huang@intel.com, keirf@google.com, 
	kent.overstreet@linux.dev, kirill.shutemov@intel.com, liam.merwick@oracle.com, 
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
	rppt@kernel.org, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="us-ascii"

On Wed, May 14, 2025, Ackerley Tng wrote:
> guestmem_hugetlb is an allocator for guest_memfd. It wraps HugeTLB to
> provide huge folios for guest_memfd.
> 
> This patch also introduces guestmem_allocator_operations as a set of
> operations that allocators for guest_memfd can provide. In a later
> patch, guest_memfd will use these operations to manage pages from an
> allocator.
> 
> The allocator operations are memory-management specific and are placed
> in mm/ so key mm-specific functions do not have to be exposed
> unnecessarily.

This code doesn't have to be put in mm/, all of the #includes are to <linux/xxx.h>.
Unless I'm missing something, what you actually want to avoid is _exporting_ mm/
APIs, and for that all that is needed is ensure the code is built-in to the kernel
binary, not to kvm.ko.

diff --git a/virt/kvm/Makefile.kvm b/virt/kvm/Makefile.kvm
index d047d4cf58c9..c18c77e8a638 100644
--- a/virt/kvm/Makefile.kvm
+++ b/virt/kvm/Makefile.kvm
@@ -13,3 +13,5 @@ kvm-$(CONFIG_HAVE_KVM_IRQ_ROUTING) += $(KVM)/irqchip.o
 kvm-$(CONFIG_HAVE_KVM_DIRTY_RING) += $(KVM)/dirty_ring.o
 kvm-$(CONFIG_HAVE_KVM_PFNCACHE) += $(KVM)/pfncache.o
 kvm-$(CONFIG_KVM_GUEST_MEMFD) += $(KVM)/guest_memfd.o
+
+obj-$(subst m,y,$(CONFIG_KVM_GUEST_MEMFD)) += $(KVM)/guest_memfd_hugepages.o
\ No newline at end of file

People may want the code to live in mm/ for maintenance and ownership reasons
(or not, I haven't followed the discussions on hugepage support), but that's a
very different justification than what's described in the changelog.

And if the _only_ user is guest_memfd, putting this in mm/ feels quite weird.
And if we anticipate other users, the name guestmem_hugetlb is weird, because
AFAICT there's nothing in here that is in any way guest specific, it's just a
few APIs for allocating and accounting hugepages.

Personally, I don't see much point in trying to make this a "generic" library,
in quotes because the whole guestmem_xxx namespace makes it anything but generic.
I don't see anything in mm/guestmem_hugetlb.c that makes me go "ooh, that's nasty,
I'm glad this is handled by a library".  But if we want to go straight to a
library, it should be something that is really truly generic, i.e. not "guest"
specific in any way.

> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> 
> Change-Id: I3cafe111ea7b3c84755d7112ff8f8c541c11136d
> ---
>  include/linux/guestmem.h      |  20 +++++
>  include/uapi/linux/guestmem.h |  29 +++++++
>  mm/Kconfig                    |   5 +-
>  mm/guestmem_hugetlb.c         | 159 ++++++++++++++++++++++++++++++++++
>  4 files changed, 212 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/guestmem.h
>  create mode 100644 include/uapi/linux/guestmem.h


..

> diff --git a/include/uapi/linux/guestmem.h b/include/uapi/linux/guestmem.h
> new file mode 100644
> index 000000000000..2e518682edd5
> --- /dev/null
> +++ b/include/uapi/linux/guestmem.h

With my KVM hat on, NAK to defining uAPI in a library like this.  This subtly
defines uAPI for KVM, and effectively any other userspace-facing entity that
utilizes the library/allocator.  KVM's uAPI needs to be defined by KVM, period.

There's absolutely zero reason to have guestmem_hugetlb_setup() take in flags.
Explicitly pass the page size, or if preferred, the page_size_log, and let the
caller figure out how to communicate the size to the kernel.

IMO, the whole MAP_HUGE_xxx approach is a (clever) hack to squeeze the desired
size into mmap() flags.  I don't see any reason to carry that forward to guest_memfd.
For once, we had the foresight to reserve some space in KVM's uAPI structure, so
there's no need to squeeze things into flags.

E.g. we could do something like this:

diff --git include/uapi/linux/kvm.h include/uapi/linux/kvm.h
index 42053036d38d..b79914472d27 100644
--- include/uapi/linux/kvm.h
+++ include/uapi/linux/kvm.h
@@ -1605,11 +1605,16 @@ struct kvm_memory_attributes {
 #define KVM_CREATE_GUEST_MEMFD _IOWR(KVMIO,  0xd4, struct kvm_create_guest_memfd)
 #define GUEST_MEMFD_FLAG_MMAP          (1ULL << 0)
 #define GUEST_MEMFD_FLAG_INIT_SHARED   (1ULL << 1)
+#define GUEST_MEMFD_FLAG_HUGE_PAGES    (1ULL << 2)
 
 struct kvm_create_guest_memfd {
        __u64 size;
        __u64 flags;
-       __u64 reserved[6];
+       __u8 huge_page_size_log2;
+       __u8 reserve8;
+       __u16 reserve16;
+       __u32 reserve32;
+       __u64 reserved[5];
 };
 
 #define KVM_PRE_FAULT_MEMORY   _IOWR(KVMIO, 0xd5, struct kvm_pre_fault_memory)

And not have to burn 6 bits of flags to encode the size in a weird location.

But that's a detail for KVM to sort out, which is exactly my point; how this is
presented to userspace for guest_memfd is question for KVM.

> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI_LINUX_GUESTMEM_H
> +#define _UAPI_LINUX_GUESTMEM_H
> +
> +/*
> + * Huge page size must be explicitly defined when using the guestmem_hugetlb
> + * allocator for guest_memfd.  It is the responsibility of the application to
> + * know which sizes are supported on the running system.  See mmap(2) man page
> + * for details.
> + */
> +
> +#define GUESTMEM_HUGETLB_FLAG_SHIFT	58
> +#define GUESTMEM_HUGETLB_FLAG_MASK	0x3fUL
> +
> +#define GUESTMEM_HUGETLB_FLAG_16KB	(14UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
> +#define GUESTMEM_HUGETLB_FLAG_64KB	(16UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
> +#define GUESTMEM_HUGETLB_FLAG_512KB	(19UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
> +#define GUESTMEM_HUGETLB_FLAG_1MB	(20UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
> +#define GUESTMEM_HUGETLB_FLAG_2MB	(21UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
> +#define GUESTMEM_HUGETLB_FLAG_8MB	(23UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
> +#define GUESTMEM_HUGETLB_FLAG_16MB	(24UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
> +#define GUESTMEM_HUGETLB_FLAG_32MB	(25UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
> +#define GUESTMEM_HUGETLB_FLAG_256MB	(28UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
> +#define GUESTMEM_HUGETLB_FLAG_512MB	(29UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
> +#define GUESTMEM_HUGETLB_FLAG_1GB	(30UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
> +#define GUESTMEM_HUGETLB_FLAG_2GB	(31UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
> +#define GUESTMEM_HUGETLB_FLAG_16GB	(34UL << GUESTMEM_HUGETLB_FLAG_SHIFT)
> +
> +#endif /* _UAPI_LINUX_GUESTMEM_H */

...

> +const struct guestmem_allocator_operations guestmem_hugetlb_ops = {
> +	.inode_setup = guestmem_hugetlb_setup,
> +	.inode_teardown = guestmem_hugetlb_teardown,
> +	.alloc_folio = guestmem_hugetlb_alloc_folio,
> +	.nr_pages_in_folio = guestmem_hugetlb_nr_pages_in_folio,
> +};
> +EXPORT_SYMBOL_GPL(guestmem_hugetlb_ops);

Why are these bundled into a structure?  AFAICT, that adds layers of indirection
for absolutely no reason.  And especially on the KVM guest_memfd side, implementing
a pile of infrastructure to support "custom" allocators is very premature.  Without
a second "custom" allocator, it's impossible to determine if the indirection
provided is actually a good design.  I.e. all of the kvm_gmem_has_custom_allocator()
logic in guest_memfd.c is just HugeTLB logic buried behind a layer of unnecessary
indirection.

