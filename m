Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1472867F882
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Jan 2023 15:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234726AbjA1OJJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Jan 2023 09:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjA1OJI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Jan 2023 09:09:08 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549303AB2;
        Sat, 28 Jan 2023 06:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674914947; x=1706450947;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=jGLKHUiTup0wR3d32S/+noCZxMpThHkENbyPsFWyI2U=;
  b=hGwlUhaGk4Z3yhFpVFhRkF23YVgK6WYNy+8ykWxxLqPozBhYUuM/HKQh
   TbwqLe7akLVT0AW/cfxxmRWgHDVj9khl/IYUr7YwvIf23TSDnHyl5v6nX
   Ein1ypv9Budyw0o3npCbyegSTAdH0ExWClGYLHz+yW0p1KIkxHzOzk67d
   5YPvRYOFW8fAsdP8zIU1OZqQYhLf7UwuQzLSeLS0f5uBJB+PxcNye42d5
   uyjwLk5LPYF/kMbelXhV581ApRzBo/oPWYC6hN/O9RBSmLmguEO3XijVo
   ixhL3sSUUoVuwJbXV+yLWhZSKvjNvKxEK2v/XRftXhgu2IC3V/IjgS36n
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="328579180"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="328579180"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 06:08:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="663602794"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="663602794"
Received: from chaop.bj.intel.com (HELO localhost) ([10.240.192.105])
  by orsmga002.jf.intel.com with ESMTP; 28 Jan 2023 06:08:15 -0800
Date:   Sat, 28 Jan 2023 22:00:30 +0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        wei.w.wang@intel.com
Subject: Re: [PATCH v10 9/9] KVM: Enable and expose KVM_MEM_PRIVATE
Message-ID: <20230128140030.GB700688@chaop.bj.intel.com>
Reply-To: Chao Peng <chao.p.peng@linux.intel.com>
References: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
 <20221202061347.1070246-10-chao.p.peng@linux.intel.com>
 <Y8HwvTik/2avrCOU@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8HwvTik/2avrCOU@google.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 14, 2023 at 12:01:01AM +0000, Sean Christopherson wrote:
> On Fri, Dec 02, 2022, Chao Peng wrote:
... 
> Strongly prefer to use similar logic to existing code that detects wraps:
> 
> 		mem->restricted_offset + mem->memory_size < mem->restricted_offset
> 
> This is also where I'd like to add the "gfn is aligned to offset" check, though
> my brain is too fried to figure that out right now.

Used count_trailing_zeros() for this TODO, unsure we have other better
approach.

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index afc8c26fa652..fd34c5f7cd2f 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -56,6 +56,7 @@
 #include <asm/processor.h>
 #include <asm/ioctl.h>
 #include <linux/uaccess.h>
+#include <linux/count_zeros.h>
 
 #include "coalesced_mmio.h"
 #include "async_pf.h"
@@ -2087,6 +2088,19 @@ static bool kvm_check_memslot_overlap(struct kvm_memslots *slots, int id,
 	return false;
 }
 
+/*
+ * Return true when ALIGNMENT(offset) >= ALIGNMENT(gpa).
+ */
+static bool kvm_check_rmem_offset_alignment(u64 offset, u64 gpa)
+{
+	if (!offset)
+		return true;
+	if (!gpa)
+		return false;
+
+	return !!(count_trailing_zeros(offset) >= count_trailing_zeros(gpa));
+}
+
 /*
  * Allocate some memory and give it an address in the guest physical address
  * space.
@@ -2128,7 +2142,8 @@ int __kvm_set_memory_region(struct kvm *kvm,
 	if (mem->flags & KVM_MEM_PRIVATE &&
 	    (mem->restrictedmem_offset & (PAGE_SIZE - 1) ||
 	     mem->restrictedmem_offset + mem->memory_size < mem->restrictedmem_offset ||
-	     0 /* TODO: require gfn be aligned with restricted offset */))
+	     !kvm_check_rmem_offset_alignment(mem->restrictedmem_offset,
+					      mem->guest_phys_addr)))
 		return -EINVAL;
 	if (as_id >= kvm_arch_nr_memslot_as_ids(kvm) || id >= KVM_MEM_SLOTS_NUM)
 		return -EINVAL;

