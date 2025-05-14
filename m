Return-Path: <linux-fsdevel+bounces-49031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05227AB799A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 01:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CACE516C930
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 23:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE66230996;
	Wed, 14 May 2025 23:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n7xI9McQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA2D22F397
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 23:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747266189; cv=none; b=gEVA2VVrBuAlgYSqcTtbnDnKqaL+d8+qOH0SMeZNSo8VNYbO1nQ3QPjmFWSIQN3QCsPsb9VYVROxQJDhG7Zmy9pJQqGYtU67WZAi1Ey9zhGg7Mg/F6AI//A4P0pQdYrk6jNMHDDZOE8yH85ar6BTA1jh9/c7p754RNCyYZdUDhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747266189; c=relaxed/simple;
	bh=/oBHKxiR+7UKkvG/s3QvWspUBplbBTSgoXfmvQIq1WY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G0MHzZvdKrKpQno4aUsoMrghhrP7cBySRQ1+8Ni3HcByHXCxlzCCfmOy+2FpaB64OG40P3d5QY/h6iQRrPykGzCJNDOXQdA2fckg3Iqartu8u7zTPxAkB0auu1Fzf0lYRXfa3FN5GycDqyQ7jUxZeYKn9r1umpi+2MDtwcNUeQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n7xI9McQ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30adbe9b568so291140a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 16:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747266187; x=1747870987; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XWIedWKko0q0l+HgOrPiOCPy2pv6PChoegA1MNDO8i4=;
        b=n7xI9McQE9IKDqsuBfIpWiEdT2YzXLvco8syvpjTufkwFnEzA0NYojLdnLmar0vPYm
         +PQYMDhSduvA31HJm9mqxxV7I8anv78KfJkpAMgmF0gq8HeEn+9Z1fLMV/NxOT+ORtJo
         6kYfx0znglrKhGmIO0FhW3rjB6OI6TRP1C7EFCzFPhFurhX1dwlBZCN+gX3pE07LECDr
         nAXIcmSeyI7SzJJ7h/o1h26+mtTa/wPa6F4+DABGXtXyONiXCzirmxR0Ijad4qCUEpE3
         W5ttRP+68rSVzXuU5RzJe/yEP5IrPCUVRi1BhjjWn0ZOhlVSJP4h8RH9lyWIypT5vCez
         JMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747266187; x=1747870987;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XWIedWKko0q0l+HgOrPiOCPy2pv6PChoegA1MNDO8i4=;
        b=FegNzaJiMJYo01TYKlLZWRIwjcyUldCuCvRHFV/t3RLhN9xgFN8mOaZecP3Z0QnRI1
         1No4xSKSLF1h1/OzY3jvunwEp+W9DPZ46l1EEXVErBNW6OXtSL5wzD5tKjVBb5vnK6rY
         l8SlifEL8wLE1FKnlbeZpgihMIV9PE8SgEDGjlO4EBGFsdrUYQfFK5wu6CHATmfbrSab
         BHopNl9BCe/QuhAh0DBY/W4xopVWwZg61S+gjIza/BTmRHUPMNQZ95Ik3WGD7fawRNSk
         HYiMA7syP3I5SFvxPaCcCPuTBc/AN3oXsYsEQLFVheVaqN5xSmZwJB6MvUrkaD9hB/he
         oDOg==
X-Forwarded-Encrypted: i=1; AJvYcCUoKxeuDzYpJGPUFp504XGLK7JXndK8oNesRKB7X6tC9jfGG96CzO55W8LIjUYQfvX48OYmxIbZEOvAx63c@vger.kernel.org
X-Gm-Message-State: AOJu0YxZlnlKZ63yPGvvzxsMERfe7BKmLZYbCDMXR9/oOhN0hDHySiMN
	n86BDwfHWlCkZqzNIRvfntf8rm082odSfckktEuJ/E2TVUuxiJE7ElAeuJ6y8vt2E2P4WwdLkea
	kap8qB58tifHVKz68M+Ke/w==
X-Google-Smtp-Source: AGHT+IHesn3dOk6yj3lGjW9oGrsY34nuGC/3KJDKeYlh++dy4L/FXCRUxYHz7/nH0P6zJ+IQHTR/7qIbv4kewoYFFA==
X-Received: from pjbso17.prod.google.com ([2002:a17:90b:1f91:b0:301:2679:9d9])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4a85:b0:30a:3dde:6af4 with SMTP id 98e67ed59e1d1-30e2e687a50mr6882572a91.31.1747266186577;
 Wed, 14 May 2025 16:43:06 -0700 (PDT)
Date: Wed, 14 May 2025 16:41:45 -0700
In-Reply-To: <cover.1747264138.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747264138.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
Message-ID: <237590b163506821120734a0c8aad95d9c7ef299.1747264138.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 06/51] KVM: Query guest_memfd for private/shared status
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

Query guest_memfd for private/shared status if those guest_memfds
track private/shared status.

With this patch, Coco VMs can use guest_memfd for both shared and
private memory. If Coco VMs choose to use guest_memfd for both
shared and private memory, by creating guest_memfd with the
GUEST_MEMFD_FLAG_SUPPORT_SHARED flag, guest_memfd will be used to
provide the private/shared status of the memory, instead of
kvm->mem_attr_array.

Change-Id: I8f23d7995c12242aa4e09ccf5ec19360e9c9ed83
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/linux/kvm_host.h | 19 ++++++++++++-------
 virt/kvm/guest_memfd.c   | 22 ++++++++++++++++++++++
 2 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index b317392453a5..91279e05e010 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2508,12 +2508,22 @@ static inline void kvm_prepare_memory_fault_exit(struct kvm_vcpu *vcpu,
 }
 
 #ifdef CONFIG_KVM_GMEM_SHARED_MEM
+
 bool kvm_gmem_memslot_supports_shared(const struct kvm_memory_slot *slot);
+bool kvm_gmem_is_private(struct kvm_memory_slot *slot, gfn_t gfn);
+
 #else
+
 static inline bool kvm_gmem_memslot_supports_shared(const struct kvm_memory_slot *slot)
 {
 	return false;
 }
+
+static inline bool kvm_gmem_is_private(struct kvm_memory_slot *slot, gfn_t gfn)
+{
+	return false;
+}
+
 #endif /* CONFIG_KVM_GMEM_SHARED_MEM */
 
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
@@ -2544,13 +2554,8 @@ static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
 		return false;
 
 	slot = gfn_to_memslot(kvm, gfn);
-	if (kvm_slot_has_gmem(slot) && kvm_gmem_memslot_supports_shared(slot)) {
-		/*
-		 * For now, memslots only support in-place shared memory if the
-		 * host is allowed to mmap memory (i.e., non-Coco VMs).
-		 */
-		return false;
-	}
+	if (kvm_slot_has_gmem(slot) && kvm_gmem_memslot_supports_shared(slot))
+		return kvm_gmem_is_private(slot, gfn);
 
 	return kvm_get_memory_attributes(kvm, gfn) & KVM_MEMORY_ATTRIBUTE_PRIVATE;
 }
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 6f6c4d298f8f..853e989bdcb2 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -865,6 +865,28 @@ bool kvm_gmem_memslot_supports_shared(const struct kvm_memory_slot *slot)
 }
 EXPORT_SYMBOL_GPL(kvm_gmem_memslot_supports_shared);
 
+bool kvm_gmem_is_private(struct kvm_memory_slot *slot, gfn_t gfn)
+{
+	struct inode *inode;
+	struct file *file;
+	pgoff_t index;
+	bool ret;
+
+	file = kvm_gmem_get_file(slot);
+	if (!file)
+		return false;
+
+	index = kvm_gmem_get_index(slot, gfn);
+	inode = file_inode(file);
+
+	filemap_invalidate_lock_shared(inode->i_mapping);
+	ret = kvm_gmem_shareability_get(inode, index) == SHAREABILITY_GUEST;
+	filemap_invalidate_unlock_shared(inode->i_mapping);
+
+	fput(file);
+	return ret;
+}
+
 #else
 #define kvm_gmem_mmap NULL
 #endif /* CONFIG_KVM_GMEM_SHARED_MEM */
-- 
2.49.0.1045.g170613ef41-goog


