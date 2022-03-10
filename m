Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11294D48D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 15:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242863AbiCJOLv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 09:11:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242760AbiCJOL1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:11:27 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C66F9A4D4;
        Thu, 10 Mar 2022 06:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646921425; x=1678457425;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=aXDmGBTRlSAIbebZ1eKgmeAE+5/9H+lFwtsMHbxfleU=;
  b=Z4VC3B9yaIDESl8IUUm7CWKeW5VI6Gy+C9mvHguhOTBm2d2Y6YcToDCJ
   ukrwNLoy9+V4A23zgQZnbKdp2JBre5P1r45C8i0nTL4AiEAnYjImlPzxF
   j2RZCdeatisICJLy3cpI26A4rMeQ6DwnbPiRq4mS3wGZfqYSPvC9n3+G0
   yKrphlTd8LiScJNN79C1qGinNO5Vse3NVur9/27lp/O+yw82haIuLzLIX
   YcD+PkJhk9+p4yh97XyfxSnFoYJvJb3NjWIKgYOOTodBVUwq5t+qN0bqm
   9wW0CevEEJ2BsBXsWwVT/01Lm0XhXVWIdXTk+jQUS3eWMHgHgNWk2l/bR
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="252823460"
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="252823460"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 06:10:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="554655000"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 10 Mar 2022 06:10:16 -0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, qemu-devel@nongnu.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com
Subject: [PATCH v5 06/13] KVM: Use kvm_userspace_memory_region_ext
Date:   Thu, 10 Mar 2022 22:09:04 +0800
Message-Id: <20220310140911.50924-7-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the new extended memslot structure kvm_userspace_memory_region_ext.
The extended part (private_fd/ private_offset) will be copied from
userspace only when KVM_MEM_PRIVATE is set. Internally old
kvm_userspace_memory_region will still be used for places where the
extended fields are not needed.

Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 arch/x86/kvm/x86.c       | 12 ++++++------
 include/linux/kvm_host.h |  4 ++--
 virt/kvm/kvm_main.c      | 30 ++++++++++++++++++++----------
 3 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8c06b8204fca..1d9dbef67715 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11757,13 +11757,13 @@ void __user * __x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 	}
 
 	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
-		struct kvm_userspace_memory_region m;
+		struct kvm_userspace_memory_region_ext m;
 
-		m.slot = id | (i << 16);
-		m.flags = 0;
-		m.guest_phys_addr = gpa;
-		m.userspace_addr = hva;
-		m.memory_size = size;
+		m.region.slot = id | (i << 16);
+		m.region.flags = 0;
+		m.region.guest_phys_addr = gpa;
+		m.region.userspace_addr = hva;
+		m.region.memory_size = size;
 		r = __kvm_set_memory_region(kvm, &m);
 		if (r < 0)
 			return ERR_PTR_USR(r);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 3be8116079d4..c92c70174248 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1082,9 +1082,9 @@ enum kvm_mr_change {
 };
 
 int kvm_set_memory_region(struct kvm *kvm,
-			  const struct kvm_userspace_memory_region *mem);
+		const struct kvm_userspace_memory_region_ext *region_ext);
 int __kvm_set_memory_region(struct kvm *kvm,
-			    const struct kvm_userspace_memory_region *mem);
+		const struct kvm_userspace_memory_region_ext *region_ext);
 void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot);
 void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen);
 int kvm_arch_prepare_memory_region(struct kvm *kvm,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 69c318fdff61..d11a2628b548 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1809,8 +1809,9 @@ static bool kvm_check_memslot_overlap(struct kvm_memslots *slots, int id,
  * Must be called holding kvm->slots_lock for write.
  */
 int __kvm_set_memory_region(struct kvm *kvm,
-			    const struct kvm_userspace_memory_region *mem)
+		const struct kvm_userspace_memory_region_ext *region_ext)
 {
+	const struct kvm_userspace_memory_region *mem = &region_ext->region;
 	struct kvm_memory_slot *old, *new;
 	struct kvm_memslots *slots;
 	enum kvm_mr_change change;
@@ -1913,24 +1914,24 @@ int __kvm_set_memory_region(struct kvm *kvm,
 EXPORT_SYMBOL_GPL(__kvm_set_memory_region);
 
 int kvm_set_memory_region(struct kvm *kvm,
-			  const struct kvm_userspace_memory_region *mem)
+		const struct kvm_userspace_memory_region_ext *region_ext)
 {
 	int r;
 
 	mutex_lock(&kvm->slots_lock);
-	r = __kvm_set_memory_region(kvm, mem);
+	r = __kvm_set_memory_region(kvm, region_ext);
 	mutex_unlock(&kvm->slots_lock);
 	return r;
 }
 EXPORT_SYMBOL_GPL(kvm_set_memory_region);
 
 static int kvm_vm_ioctl_set_memory_region(struct kvm *kvm,
-					  struct kvm_userspace_memory_region *mem)
+			struct kvm_userspace_memory_region_ext *region_ext)
 {
-	if ((u16)mem->slot >= KVM_USER_MEM_SLOTS)
+	if ((u16)region_ext->region.slot >= KVM_USER_MEM_SLOTS)
 		return -EINVAL;
 
-	return kvm_set_memory_region(kvm, mem);
+	return kvm_set_memory_region(kvm, region_ext);
 }
 
 #ifndef CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT
@@ -4476,14 +4477,23 @@ static long kvm_vm_ioctl(struct file *filp,
 		break;
 	}
 	case KVM_SET_USER_MEMORY_REGION: {
-		struct kvm_userspace_memory_region kvm_userspace_mem;
+		struct kvm_userspace_memory_region_ext region_ext;
 
 		r = -EFAULT;
-		if (copy_from_user(&kvm_userspace_mem, argp,
-						sizeof(kvm_userspace_mem)))
+		if (copy_from_user(&region_ext, argp,
+				sizeof(struct kvm_userspace_memory_region)))
 			goto out;
+		if (region_ext.region.flags & KVM_MEM_PRIVATE) {
+			int offset = offsetof(
+				struct kvm_userspace_memory_region_ext,
+				private_offset);
+			if (copy_from_user(&region_ext.private_offset,
+					   argp + offset,
+					   sizeof(region_ext) - offset))
+				goto out;
+		}
 
-		r = kvm_vm_ioctl_set_memory_region(kvm, &kvm_userspace_mem);
+		r = kvm_vm_ioctl_set_memory_region(kvm, &region_ext);
 		break;
 	}
 	case KVM_GET_DIRTY_LOG: {
-- 
2.17.1

