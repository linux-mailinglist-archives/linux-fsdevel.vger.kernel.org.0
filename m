Return-Path: <linux-fsdevel+bounces-64520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AD2BEB7E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 22:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 576694F0E4B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 20:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFDD33DEDA;
	Fri, 17 Oct 2025 20:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QtyJJi+N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026A8337BB3
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 20:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760731965; cv=none; b=OdM6qqHnY+A/wElAkT2bD1psBKcTBUSg76v1+vgn2nidCwXVXEMt23ZWZu0VAwrvcTEoyyFysvM9H/Drkir455WMuz7/+YY2KyQx/lfYrRq3TBaYdga4a2J8mU+J/hmN8X1YxxiHUg/Ainu8mP+BB3vM/bh+ji8hcioKPIyJUzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760731965; c=relaxed/simple;
	bh=K6k45kPnokdfX9muKHxHIZHUOmJQUKyI0MnKREcy6dw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=shig7ZklpsdwPB6YDePOK8/t2Rf4+Zw1LSqgjUhHdenl9lhFtyH4eapcWG5pchXwGduK5J6H3Fl+dDchLPPpFKFGr0Pu/ksNAY2dNFR1fAND338EpK0Ia9y2iQGDbe5/ACcTFKi0qCOBGvI2SRqe16pJ8rFCnrAWVzPGKe8tfEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QtyJJi+N; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-290da17197eso16522965ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Oct 2025 13:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760731959; x=1761336759; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=azUJ8YbBz5p8iXsJA90gvxNkNoC7gBdMtAmKtMeo9eg=;
        b=QtyJJi+NBgHeKKwv533/uMBOtRwbo8/d3zjUhHWtUNCM1ghTcJUeL3+mAvUbz3eQDq
         CWrTLgexdw6lOkYc8cfpjSeU9jkrSKUmICsW4x/kGItN7QJ338gsV5HogiykLmhOlrfs
         ozd+clEhaGcrVSXH+kR8NE0Ht3Q9rnXIg17/fLRrUUSuA1eFLAHO5T612bRPHjUx5dVZ
         /q7mVptLUQX3dHVwBdLCgjbRJEziwHuOwSCP8VvGzIvaCEnZ0vfBldNw5YzHByY/61h+
         g44sZODV7ZfK7UIkoeoE9+aFHYwJiR954l9l0p/+rtawsKhuV2ID3Aj/iphIJhRau5TR
         9KHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760731959; x=1761336759;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=azUJ8YbBz5p8iXsJA90gvxNkNoC7gBdMtAmKtMeo9eg=;
        b=w2M9GlZdviHenf4HdG1gpD3l5faQFiCiPxEGpZdJUPvlSFblIdtkNC/fx/PHyRLH8k
         5BbJp7EVSRBFEZPpUnnD/eic5Qpj8HOBaQ3cPiXxpqGDeFWOy6ilov9PIT1YDkjvDqvi
         tKwJ7odzapjEqw+z7nopZFcpMAXt2Zh4/8T0bsy9262a7TJGhQib2fyLSCnrPVPDfdtN
         jdsmA0OQ/yEjgdqog/ajyeO6d/UbNXWaMwP4hRJYuJdQCX5GxMbc/cdsJVeWbHYfd1Qh
         tv/TK0PDK4jwvAok6QuW4mHqMP4uc6wW6PFhor1GyVUAwqywY9EPrQbB2oR0nKjSR1eN
         K0pA==
X-Forwarded-Encrypted: i=1; AJvYcCXMj3GGTWrtU+lIJaI1UZ06FAHMjAd3n07rbcjn0CwUWF2FHmpAzcQeuu7RnwfoO1d1mKyMh7Fpb5jI05lN@vger.kernel.org
X-Gm-Message-State: AOJu0YxzWr4nslWx0MUWjT194mWiX0TKT1nmzwe8uv54XMYX03tOuPEV
	6koiTa1yYiA9oJraMNvx42J84v+uszveOWm0EC781HTx/2WSPRIBiyPhKf9+G83xOiJ/i/AU7u3
	OBKmeQy48mcBDndXJVuue1cx7xg==
X-Google-Smtp-Source: AGHT+IGjtEU34dqqnybB19rBgoWD/tF1TyeATlVnN+HcnvWeM3cm6kpWoOjHHimLdS4u0Zp3tLd6gH6GokckyTqWLA==
X-Received: from pjbbk24.prod.google.com ([2002:a17:90b:818:b0:33b:a0ae:940])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:cecb:b0:290:c94b:8381 with SMTP id d9443c01a7336-290c9c89dbbmr63619355ad.7.1760731958742;
 Fri, 17 Oct 2025 13:12:38 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:11:47 -0700
In-Reply-To: <cover.1760731772.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <a3795f7fb4f785ced19abe18c2f33aa478c4d202.1760731772.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 06/37] KVM: guest_memfd: Update kvm_gmem_populate() to
 use gmem attributes
From: Ackerley Tng <ackerleytng@google.com>
To: cgroups@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org
Cc: ackerleytng@google.com, akpm@linux-foundation.org, 
	binbin.wu@linux.intel.com, bp@alien8.de, brauner@kernel.org, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, corbet@lwn.net, 
	dave.hansen@intel.com, dave.hansen@linux.intel.com, david@redhat.com, 
	dmatlack@google.com, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	haibo1.xu@intel.com, hannes@cmpxchg.org, hch@infradead.org, hpa@zytor.com, 
	hughd@google.com, ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, 
	jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com, 
	jun.miao@intel.com, kai.huang@intel.com, keirf@google.com, 
	kent.overstreet@linux.dev, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, 
	maobibo@loongson.cn, mathieu.desnoyers@efficios.com, maz@kernel.org, 
	mhiramat@kernel.org, mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com, 
	mingo@redhat.com, mlevitsk@redhat.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, peterx@redhat.com, 
	pgonda@google.com, prsampat@amd.com, pvorel@suse.cz, qperret@google.com, 
	richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, roypat@amazon.co.uk, rppt@kernel.org, seanjc@google.com, 
	shakeel.butt@linux.dev, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	tglx@linutronix.de, thomas.lendacky@amd.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, wyihan@google.com, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

Update the guest_memfd populate() flow to pull memory attributes from the
gmem instance instead of the VM when KVM is not configured to track
shared/private status in the VM.

Rename the per-VM API to make it clear that it retrieves per-VM
attributes, i.e. is not suitable for use outside of flows that are
specific to generic per-VM attributes.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c   |  2 +-
 include/linux/kvm_host.h |  5 ++++-
 virt/kvm/guest_memfd.c   | 26 +++++++++++++++++++++++---
 virt/kvm/kvm_main.c      |  8 +++-----
 4 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index e4542b37b0db6..52189853cf4ab 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7897,7 +7897,7 @@ static bool hugepage_has_attrs(struct kvm *kvm, struct kvm_memory_slot *slot,
 	const unsigned long end = start + KVM_PAGES_PER_HPAGE(level);
 
 	if (level == PG_LEVEL_2M)
-		return kvm_range_has_memory_attributes(kvm, start, end, ~0, attrs);
+		return kvm_range_has_vm_memory_attributes(kvm, start, end, ~0, attrs);
 
 	for (gfn = start; gfn < end; gfn += KVM_PAGES_PER_HPAGE(level - 1)) {
 		if (hugepage_test_mixed(slot, gfn, level - 1) ||
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index b8418cc5851f1..b48632ee242b3 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2535,12 +2535,15 @@ static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
 #endif
 
 #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
-bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
+extern bool vm_memory_attributes;
+bool kvm_range_has_vm_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 				     unsigned long mask, unsigned long attrs);
 bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
 					struct kvm_gfn_range *range);
 bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
 					 struct kvm_gfn_range *range);
+#else
+#define vm_memory_attributes false
 #endif /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
 
 unsigned long kvm_gmem_get_memory_attributes(struct kvm *kvm, gfn_t gfn);
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index f62facc3ab776..855e682041311 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -907,10 +907,30 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_get_pfn);
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_POPULATE
+static bool kvm_gmem_range_is_private(struct gmem_inode *gi, pgoff_t index,
+				      size_t nr_pages, struct kvm *kvm, gfn_t gfn)
+{
+	pgoff_t end = index + nr_pages - 1;
+	void *entry;
+
+	if (vm_memory_attributes)
+		return kvm_range_has_vm_memory_attributes(kvm, gfn, gfn + nr_pages,
+						       KVM_MEMORY_ATTRIBUTE_PRIVATE,
+						       KVM_MEMORY_ATTRIBUTE_PRIVATE);
+
+	mt_for_each(&gi->attributes, entry, index, end) {
+		if (xa_to_value(entry) != attributes)
+			return false;
+	}
+
+	return true;
+}
+
 long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src, long npages,
 		       kvm_gmem_populate_cb post_populate, void *opaque)
 {
 	struct kvm_memory_slot *slot;
+	struct gmem_inode *gi;
 	void __user *p;
 
 	int ret = 0, max_order;
@@ -929,6 +949,8 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src, long
 	if (!file)
 		return -EFAULT;
 
+	gi = GMEM_I(file_inode(file));
+
 	filemap_invalidate_lock(file->f_mapping);
 
 	npages = min_t(ulong, slot->npages - (start_gfn - slot->base_gfn), npages);
@@ -962,9 +984,7 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src, long
 			(npages - i) < (1 << max_order));
 
 		ret = -EINVAL;
-		while (!kvm_range_has_memory_attributes(kvm, gfn, gfn + (1 << max_order),
-							KVM_MEMORY_ATTRIBUTE_PRIVATE,
-							KVM_MEMORY_ATTRIBUTE_PRIVATE)) {
+		while (!kvm_gmem_range_is_private(gi, index, 1 << max_order, kvm, gfn)) {
 			if (!max_order)
 				goto put_folio_and_exit;
 			max_order--;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index c73ebdb73070e..35166754a22b4 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -103,9 +103,7 @@ module_param(allow_unsafe_mappings, bool, 0444);
 
 #ifdef CONFIG_KVM_MEMORY_ATTRIBUTES
 #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
-static bool vm_memory_attributes = true;
-#else
-#define vm_memory_attributes false
+bool vm_memory_attributes = true;
 #endif
 DEFINE_STATIC_CALL_RET0(__kvm_get_memory_attributes, kvm_get_memory_attributes_t);
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(STATIC_CALL_KEY(__kvm_get_memory_attributes));
@@ -2457,7 +2455,7 @@ static unsigned long kvm_get_vm_memory_attributes(struct kvm *kvm, gfn_t gfn)
  * Returns true if _all_ gfns in the range [@start, @end) have attributes
  * such that the bits in @mask match @attrs.
  */
-bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
+bool kvm_range_has_vm_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 				     unsigned long mask, unsigned long attrs)
 {
 	XA_STATE(xas, &kvm->mem_attr_array, start);
@@ -2591,7 +2589,7 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 	mutex_lock(&kvm->slots_lock);
 
 	/* Nothing to do if the entire range has the desired attributes. */
-	if (kvm_range_has_memory_attributes(kvm, start, end, ~0, attributes))
+	if (kvm_range_has_vm_memory_attributes(kvm, start, end, ~0, attributes))
 		goto out_unlock;
 
 	/*
-- 
2.51.0.858.gf9c4a03a3a-goog


