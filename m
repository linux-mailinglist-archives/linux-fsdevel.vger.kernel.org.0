Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AACE947C283
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 16:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239199AbhLUPNu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 10:13:50 -0500
Received: from mga04.intel.com ([192.55.52.120]:9809 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239194AbhLUPNs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:13:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640099628; x=1671635628;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=GpzaY/v5Xy0pX72fyoYUfRrCzZUdqzkwMBDdLOr36fk=;
  b=AOClHpN8r7SfhapRWaqu4ST6+dUkSIzO9rwXpPXUABSlK4VoPBK1N6AP
   8hgtO+d26ADSbiFi8mn3hkHnZMKcMqD/aL+l6F4Q2m0g0/F6dpDTGs26p
   Q0uAemlmujWZCfpk2yGA1ZKQPGwPCnz2pCJ2yF0GJnXxGl3Z46Nq5Cyx4
   ZwYGYnYFTCf2SOUGFlpY7c8kp2CN7QuWOemuKkixyk/hcYaEwOfM+NFiV
   +EN9itZ0F63015SJjZNKi4fDIizbx6plPCv60o26AupO3sHRe0PZluYFS
   wjMxSZYMu2vq2hEuYXfhLI5s9i7Bp3rR9uzw/XJRKpGHQF+EYs7BSqnvS
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="239157806"
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="239157806"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 07:13:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="684688608"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga005.jf.intel.com with ESMTP; 21 Dec 2021 07:13:33 -0800
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
        luto@kernel.org, john.ji@intel.com, susie.li@intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com
Subject: [PATCH v3 12/15] KVM: Add KVM_EXIT_MEMORY_ERROR exit
Date:   Tue, 21 Dec 2021 23:11:22 +0800
Message-Id: <20211221151125.19446-13-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211221151125.19446-1-chao.p.peng@linux.intel.com>
References: <20211221151125.19446-1-chao.p.peng@linux.intel.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This new exit allows user space to handle memory-related errors.
Currently it supports two types (KVM_EXIT_MEM_MAP_SHARED/PRIVATE) of
errors which are used for shared memory <-> private memory conversion
in memory encryption usage.

After private memory is enabled, there are two places in KVM that can
exit to userspace to trigger private <-> shared conversion:
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
 include/uapi/linux/kvm.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index a2c1fb8c9843..d0c2af431cd9 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -297,6 +297,18 @@ struct kvm_tdx_exit {
 	} u;
 };
 
+struct kvm_memory_exit {
+#define KVM_EXIT_MEM_MAP_SHARED         1
+#define KVM_EXIT_MEM_MAP_PRIVATE        2
+	__u32 type;
+	union {
+		struct {
+			__u64 gpa;
+			__u64 size;
+		} map;
+	} u;
+};
+
 #define KVM_S390_GET_SKEYS_NONE   1
 #define KVM_S390_SKEYS_MAX        1048576
 
@@ -336,6 +348,7 @@ struct kvm_tdx_exit {
 #define KVM_EXIT_X86_BUS_LOCK     33
 #define KVM_EXIT_XEN              34
 #define KVM_EXIT_RISCV_SBI        35
+#define KVM_EXIT_MEMORY_ERROR     36
 #define KVM_EXIT_TDX              50	/* dump number to avoid conflict. */
 
 /* For KVM_EXIT_INTERNAL_ERROR */
@@ -554,6 +567,8 @@ struct kvm_run {
 			unsigned long args[6];
 			unsigned long ret[2];
 		} riscv_sbi;
+		/* KVM_EXIT_MEMORY_ERROR */
+		struct kvm_memory_exit mem;
 		/* KVM_EXIT_TDX_VMCALL */
 		struct kvm_tdx_exit tdx;
 		/* Fix the size of the union. */
-- 
2.17.1

