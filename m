Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57DA492726
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 14:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243373AbiARNXD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 08:23:03 -0500
Received: from mga06.intel.com ([134.134.136.31]:48497 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243192AbiARNWt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 08:22:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642512169; x=1674048169;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=wc/HrL4JpEiPy0hOw1D7+yU1U6huBzVxxSt7KzpRO+o=;
  b=B04TtwMI8Z6Q0OSb5WaB8avjVN4KkBlKNKP8mKDlAZs/VIJNh2sM7HzA
   3D53A5/bmI9KxAdg0mRf/kgVQ5lJhqjTcpDztbh4fSV8ag4T+r4PFGElC
   1JWdamiGyqyQfLVIoWToGuZSyKF/BJred/xV655tgtt7xx3QON44ATjPo
   J2Jqx9oTpP31Xn58oLEqekiR9++9GQpkwlrXCDLEUWpqn07d3P4nCVQVy
   AU2WlkOCwOoJaoWP5wV2LH5MM9VlLMCHeWbKCGAp2hWLG/l25RVnQiivE
   kSMfrj6ktoxYUCCrnsu4Xe4TWqjQ/IpjPe5GZez88B4e3J+hrSEMBFgta
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="305545836"
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="305545836"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 05:22:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="531791841"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 18 Jan 2022 05:22:42 -0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        qemu-devel@nongnu.org
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
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com
Subject: [PATCH v4 07/12] KVM: Add KVM_EXIT_MEMORY_ERROR exit
Date:   Tue, 18 Jan 2022 21:21:16 +0800
Message-Id: <20220118132121.31388-8-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
References: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This new KVM exit allows userspace to handle memory-related errors. It
indicates an error happens in KVM at guest memory range [gpa, gpa+size).
The flags includes additional information for userspace to handle the
error. Currently bit 0 is defined as 'private memory' where '1'
indicates error happens due to private memory access and '0' indicates
error happens due to shared memory access.

After private memory is enabled, this new exit will be used for KVM to
exit to userspace for shared memory <-> private memory conversion in
memory encryption usage.

In such usage, typically there are two kind of memory conversions:
  - explicit conversion: happens when guest explicitly calls into KVM to
    map a range (as private or shared), KVM then exits to userspace to
    do the map/unmap operations.
  - implicit conversion: happens in KVM page fault handler.
    * if the fault is due to a private memory access then causes a
      userspace exit for a shared->private conversion request when the
      page has not been allocated in the private memory backend.
    * If the fault is due to a shared memory access then causes a
      userspace exit for a private->shared conversion request when the
      page has already been allocated in the private memory backend.

Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 include/uapi/linux/kvm.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 5d6dceb1b93e..52d8938a4ba1 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -278,6 +278,7 @@ struct kvm_xen_exit {
 #define KVM_EXIT_X86_BUS_LOCK     33
 #define KVM_EXIT_XEN              34
 #define KVM_EXIT_RISCV_SBI        35
+#define KVM_EXIT_MEMORY_ERROR     36
 
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
@@ -495,6 +496,14 @@ struct kvm_run {
 			unsigned long args[6];
 			unsigned long ret[2];
 		} riscv_sbi;
+		/* KVM_EXIT_MEMORY_ERROR */
+		struct {
+#define KVM_MEMORY_EXIT_FLAG_PRIVATE	(1 << 0)
+			__u32 flags;
+			__u32 padding;
+			__u64 gpa;
+			__u64 size;
+		} memory;
 		/* Fix the size of the union. */
 		char padding[256];
 	};
-- 
2.17.1

