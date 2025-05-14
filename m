Return-Path: <linux-fsdevel+bounces-49066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A3EAB7A1B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 01:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 929AA3B0EA9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 23:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EB0265CBA;
	Wed, 14 May 2025 23:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iTFFvdb9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D8A2620E9
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 23:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747266243; cv=none; b=JnmdO3LRz9eHaw3HQNa4TrqcK8LwBOXuHK+4/PtraeBuFvLXCYfmKuBhKhZs4gAAz+1w5ZabZBRvPyX00ceQbyjPG+oOio8oPpAtMbpnlpqwDR5bQhJqEDg4x0+FjYrn30B4oWBb+TySicR3x9PqaKjP4sL7or7drrtagxIsga8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747266243; c=relaxed/simple;
	bh=hpWPV5aHOEDKO6rFgPmyIVni5fletgcR4okZkc1dIp4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DOOl+TJ/vbXTorTScqMqyU7mYzPyFGo6MC0wyI4gsPa304iYEpGtIjjViPA9sUIxZL2B6dCr2YRgZ0NS8iZCOczOxHTAn0kUL3VY3DCPmEU6Mijnq1AeK7IEJ9nt0EXtHolQVsR4V/bQm7kxUaeLZcERHoA/Og/ea6cZ59bdpeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iTFFvdb9; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22fba10f55eso2879275ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 16:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747266241; x=1747871041; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jN2ogTCvzAJBcchmVAWl03ZLuEFD8lFgW6Z8LiBDfqo=;
        b=iTFFvdb9nIUJLrJj4bTkI/ktx8t3YbZdIJrIGHr9rjLS+HsGp0mWLx5H/mYMPn+WST
         0+uRqA0RjTPEaWTxtRx1R1jSS0/CC/NdFU09B38OsPB/pryPfu85aQSzueEqFvx6mHEt
         /ROlvRHn+d06pIuyv3LpUeIX0w4MPeZJ8R2a5S30DNRVWy1inghgdTe3fR/06dPNWm+C
         IqljklrmU3OQOYVQG1zDu7xTMpa2DJdJh7+TM9tnwIE/CB3CrCbgvzI7YosX26h4WXet
         TDkf8y1bIAik5L95iaejMfEmg7oOc0uE0M+SlbcxZ5AaH+gR0ybybmCUNKuozQc+R5+R
         U17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747266241; x=1747871041;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jN2ogTCvzAJBcchmVAWl03ZLuEFD8lFgW6Z8LiBDfqo=;
        b=lhODbfEMeXlOc1WwETzs9TAtGsbZEZ40BYIM9sjAihrxQBA9TEUYhAeaSc86lSEZta
         L64OhmhJ6IvfR0TphToaXgQGVQ9jdqLgTjU3rG7pVFglvZBrxTMHWemDlHRyKZDuxpYO
         MAYW6reTQtG0bg9RnY2yk4qJKHtgq0bJyXY2v3GrqHpHNw7XMFjSwcPSLLqoCLpXxff/
         XbDAxGOhwVhxhg4FVGutOR9zSubqaxyXDFPyh0nDmH8FIl/i9n7khWFVpRIbf9DYuYm1
         whlFl3LCTEeFQM+ysUmg/9T3WrEK09AIK1NBLSylwEf1zkEJbbLJAdO1CvCje8bt5D+v
         ljxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsXYAQjR0hPQi3Kn63UsMF/7JIiSNJSej3eqrraDjmoRRP/Yv6o4zqH6BILVRxESwuix5u1FV3flDGA6KH@vger.kernel.org
X-Gm-Message-State: AOJu0YwGhuHr8hgD3GMG7D+qwO6+H5Yu4HUzCiCsmYsvCSrVhSiKS0Dy
	wg9GLK1wmoy1rmbMZqtpUZ1k0gSj2rY5HItgz2xVk4okXWmNpUx0LgpEx04V5EBFT8My7djVkPf
	kkxWodVISH5MPHfTddmE8jg==
X-Google-Smtp-Source: AGHT+IGK1505Z+7Ltj5/aIaYU2/uK6H1PmXwZ8+A0lZ5yW9OmGTcOSnh69lygj29kJbn7gmEfzs1V0Zln0gB2gFDxA==
X-Received: from plrj13.prod.google.com ([2002:a17:903:28d:b0:22f:a4aa:b819])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:198e:b0:22e:5e82:6701 with SMTP id d9443c01a7336-231b5e9cdc6mr4377715ad.18.1747266241271;
 Wed, 14 May 2025 16:44:01 -0700 (PDT)
Date: Wed, 14 May 2025 16:42:20 -0700
In-Reply-To: <cover.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <147952f80781ebf35446f07c2a36810bce4de032.1747264138.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 41/51] KVM: Add CAP to indicate support for HugeTLB as
 custom allocator
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

If this CAP returns true, then guestmem_hugetlb can be used as a
custom allocator for guest_memfd.

Change-Id: I4edef395b5bd5814b70c81788d87aa94823c35d5
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/uapi/linux/kvm.h | 1 +
 virt/kvm/kvm_main.c      | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index af486b2e4862..5012343dc2c5 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -932,6 +932,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_ARM_WRITABLE_IMP_ID_REGS 239
 #define KVM_CAP_GMEM_SHARED_MEM 240
 #define KVM_CAP_GMEM_CONVERSION 241
+#define KVM_CAP_GMEM_HUGETLB 242
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 92054b1bbd3f..230bcb853712 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4845,6 +4845,10 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 	case KVM_CAP_GMEM_SHARED_MEM:
 	case KVM_CAP_GMEM_CONVERSION:
 		return true;
+#endif
+#ifdef CONFIG_KVM_GMEM_HUGETLB
+	case KVM_CAP_GMEM_HUGETLB:
+		return true;
 #endif
 	default:
 		break;
-- 
2.49.0.1045.g170613ef41-goog


