Return-Path: <linux-fsdevel+bounces-49032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BC9AB799E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 01:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45DCB1BA43E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 23:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F67323182A;
	Wed, 14 May 2025 23:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Jh42S9J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F9C22FF37
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 23:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747266190; cv=none; b=JG+OZVphYVycYmyJIlBen8dO4JOl4X8aPmL+KjJLs1kiB68P5xENqbULVD6LNidtnXd1ZdUcEaaBjZEhDzSiOqZhQYVGX2qIJZz+AZx6tROJJx0/duyHGm+5u7kfDdke1OEk54xzwF6jC3Q7U9yEPdo2cVEOMlAhDhc77mFqW9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747266190; c=relaxed/simple;
	bh=iKx5IvzpTweaAgeru4AhASmMtm6VdZkcgLEM9HYPrv8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PNAZrACz0piSAimxpvrADb7BfAASjOLZmVXCakp6R3z0vEuxXAP5GSuO5DATtmSV1b7mYo64JKKYASX/smpwuOuOXQoiIb9ocXH2h9KjNDgLOy06B8DbKwqUDfNBf5TT/XBhKyo569o1DW94fIM2ot22qNFHIpTlGDaQea0tsAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Jh42S9J; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30ac9855e35so420204a91.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 16:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747266188; x=1747870988; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=duQaEMPI/+/8EJ+OqflXscIYsMBaL2tMJ4wppFAcdZo=;
        b=0Jh42S9JzEJNm5pM4bs11rd4rBqu/OpOxa5cgqX23fOJwDRJ4kTqF6HBCnjk45vdxq
         KapMAC9tcZK2/k0Y5nO7bhxYhaHAFTWZLhUp7ZjI3xR0lo0fgt5ZLE/EdqfigJM4ES9V
         AIiwagHgZyWt1Q7noZUKdHqm504ufoHC7GXPrmMVbHOCThhDOI8ONGeaWaxvspXbcjNP
         uLZ+VyF8PLFbTNR0ZwTolFzwoGTHgWkOY3TarRgDcOX15VQsnMsA5xCNRy2yKHF0tq2p
         8nOoQQFPIQtqsfppRMP4jFp0bVQI8c7wik2kVXJx2YdEVWsxFgaaaqkcnMqN3LpkMt/o
         I7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747266188; x=1747870988;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=duQaEMPI/+/8EJ+OqflXscIYsMBaL2tMJ4wppFAcdZo=;
        b=Sdd63DZL057qHZRx5VtMab31LFsE6OgUlsePUG23pxm9RoUy4WT+U5yKH1UEo5qC5g
         XpRaEeWMTc51msPIBdsHRGzDZRaPDfBt4SwHrvU0KEmHzHyGjVhlFygk5X16/qAS4XSm
         P48q1da0Fj30d8WXxL4Hatj9WyW+rvUwATbewmovi4Iw1/nj+ljJHTO1q9v5z4eTTrHA
         7OwLjNmyTrsPqlf5JbHnLfbNU5dp1pqcEcYvvYx8QCoKvqMqMSTmwYL3cQMiE0qyr0rg
         A86cDPnFB2jT7iCd2ZwawM35OlK2a9AuGHb3uZ9wEmt/iLGM0Hu56w/TXcvrCGWVEm59
         6j+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWay8WbEQ3PKUpKiyQaHFFh6e5+qJI3+ncE4/pSyy8oLX93QWuY0xqS5KRAbUrYsv37L1UsTp25DLfj4QQG@vger.kernel.org
X-Gm-Message-State: AOJu0YwdrwJNjpNvHw+mAlcBNlcfZE030sMbXj7IpApu3xK7wScgCl+x
	MpgGSlsdDINNmKgDZKronucmUy+6JBtzJD9GBzuElWmMyryRZcb/Nfe6RycH9tyKJN/5SsgswN+
	0bHMosLD7uVyYZC5korlTRQ==
X-Google-Smtp-Source: AGHT+IFrb+gsGiHZc/e64qLljrrwwFd5Rm0IiKqEVIeKNMAq/DWkzMG2AbDLdjpl7ubUiMkSYyuQC33P/I6kwzCn8Q==
X-Received: from pjbee11.prod.google.com ([2002:a17:90a:fc4b:b0:30a:3021:c1af])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:520f:b0:306:b65e:13a8 with SMTP id 98e67ed59e1d1-30e2e5ba382mr8485187a91.8.1747266188231;
 Wed, 14 May 2025 16:43:08 -0700 (PDT)
Date: Wed, 14 May 2025 16:41:46 -0700
In-Reply-To: <cover.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <59d0c13258bea1caec2d3eeed54bc8cb78783399.1747264138.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 07/51] KVM: guest_memfd: Add CAP KVM_CAP_GMEM_CONVERSION
From: Ackerley Tng <ackerleytng@google.com>
To: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-fsdevel@vger.kernel.org
Cc: ackerleytng@google.com, aik@amd.com, ajones@ventanamicro.com, 
	akpm@linux-foundation.org, amoorthy@google.com, anthony.yznaga@oracle.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, bfoster@redhat.com, 
	binbin.wu@linux.intel.com, brauner@kernel.org, catalin.marinas@arm.com, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, dave.hansen@intel.com, 
	david@redhat.com, dmatlack@google.com, dwmw@amazon.co.uk, 
	erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, graf@amazon.com, 
	haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, ira.weiny@intel.com, 
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

KVM_CAP_GMEM_CONVERSION indicates that guest_memfd supports
conversion.

With this patch, as long as guest_memfd supports shared memory, it
also supports conversion.

With conversion support comes tracking of private/shared memory within
guest_memfd, hence now all VM types support shared memory in
guest_memfd.

Before this patch, Coco VMs did not support shared memory because that
would allow private memory to be accessible to the host. Coco VMs now
support shared memory because with private/shared status tracked in
guest_memfd, private memory will not be allowed to be mapped into the
host.

Change-Id: I057b7bd267dd84a93fdee2e95cceb88cd9dfc647
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 arch/arm64/include/asm/kvm_host.h |  5 -----
 arch/x86/include/asm/kvm_host.h   | 10 ----------
 include/linux/kvm_host.h          | 13 -------------
 include/uapi/linux/kvm.h          |  1 +
 virt/kvm/guest_memfd.c            | 12 ++++--------
 virt/kvm/kvm_main.c               |  3 ++-
 6 files changed, 7 insertions(+), 37 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 2514779f5131..7df673a71ade 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1598,9 +1598,4 @@ static inline bool kvm_arch_supports_gmem(struct kvm *kvm)
 	return IS_ENABLED(CONFIG_KVM_GMEM);
 }
 
-static inline bool kvm_arch_vm_supports_gmem_shared_mem(struct kvm *kvm)
-{
-	return IS_ENABLED(CONFIG_KVM_GMEM_SHARED_MEM);
-}
-
 #endif /* __ARM64_KVM_HOST_H__ */
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index f72722949cae..709cc2a7ba66 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2255,18 +2255,8 @@ void kvm_configure_mmu(bool enable_tdp, int tdp_forced_root_level,
 
 #ifdef CONFIG_KVM_GMEM
 #define kvm_arch_supports_gmem(kvm) ((kvm)->arch.supports_gmem)
-
-/*
- * CoCo VMs with hardware support that use guest_memfd only for backing private
- * memory, e.g., TDX, cannot use guest_memfd with userspace mapping enabled.
- */
-#define kvm_arch_vm_supports_gmem_shared_mem(kvm)			\
-	(IS_ENABLED(CONFIG_KVM_GMEM_SHARED_MEM) &&			\
-	 ((kvm)->arch.vm_type == KVM_X86_SW_PROTECTED_VM ||		\
-	  (kvm)->arch.vm_type == KVM_X86_DEFAULT_VM))
 #else
 #define kvm_arch_supports_gmem(kvm) false
-#define kvm_arch_vm_supports_gmem_shared_mem(kvm) false
 #endif
 
 #define kvm_arch_has_readonly_mem(kvm) (!(kvm)->arch.has_protected_state)
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 91279e05e010..d703f291f467 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -729,19 +729,6 @@ static inline bool kvm_arch_supports_gmem(struct kvm *kvm)
 }
 #endif
 
-/*
- * Returns true if this VM supports shared mem in guest_memfd.
- *
- * Arch code must define kvm_arch_vm_supports_gmem_shared_mem if support for
- * guest_memfd is enabled.
- */
-#if !defined(kvm_arch_vm_supports_gmem_shared_mem) && !IS_ENABLED(CONFIG_KVM_GMEM)
-static inline bool kvm_arch_vm_supports_gmem_shared_mem(struct kvm *kvm)
-{
-	return false;
-}
-#endif
-
 #ifndef kvm_arch_has_readonly_mem
 static inline bool kvm_arch_has_readonly_mem(struct kvm *kvm)
 {
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 5b28e17f6f14..433e184f83ea 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -931,6 +931,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_X86_GUEST_MODE 238
 #define KVM_CAP_ARM_WRITABLE_IMP_ID_REGS 239
 #define KVM_CAP_GMEM_SHARED_MEM 240
+#define KVM_CAP_GMEM_CONVERSION 241
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 853e989bdcb2..8c9c9e54616b 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -1216,7 +1216,7 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
 	u64 flags = args->flags;
 	u64 valid_flags = 0;
 
-	if (kvm_arch_vm_supports_gmem_shared_mem(kvm))
+	if (IS_ENABLED(CONFIG_KVM_GMEM_SHARED_MEM))
 		valid_flags |= GUEST_MEMFD_FLAG_SUPPORT_SHARED;
 
 	if (flags & GUEST_MEMFD_FLAG_SUPPORT_SHARED)
@@ -1286,13 +1286,9 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 	    offset + size > i_size_read(inode))
 		goto err;
 
-	if (kvm_gmem_supports_shared(inode)) {
-		if (!kvm_arch_vm_supports_gmem_shared_mem(kvm))
-			goto err;
-
-		if (slot->userspace_addr &&
-		    !kvm_gmem_is_same_range(kvm, slot, file, offset))
-			goto err;
+	if (kvm_gmem_supports_shared(inode) && slot->userspace_addr &&
+	    !kvm_gmem_is_same_range(kvm, slot, file, offset)) {
+		goto err;
 	}
 
 	filemap_invalidate_lock(inode->i_mapping);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 66dfdafbb3b6..92054b1bbd3f 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4843,7 +4843,8 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 #endif
 #ifdef CONFIG_KVM_GMEM_SHARED_MEM
 	case KVM_CAP_GMEM_SHARED_MEM:
-		return !kvm || kvm_arch_vm_supports_gmem_shared_mem(kvm);
+	case KVM_CAP_GMEM_CONVERSION:
+		return true;
 #endif
 	default:
 		break;
-- 
2.49.0.1045.g170613ef41-goog


