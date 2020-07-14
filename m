Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0101021E961
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 09:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgGNHF2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 03:05:28 -0400
Received: from mga17.intel.com ([192.55.52.151]:21384 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgGNHER (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 03:04:17 -0400
IronPort-SDR: S3sOneSBhYdHhQHq2WiwtLoyzylX0NbxEGkS7VALKPlPSRvrgF29d2yrKNSlF5+SWDnKlXy9xM
 INmBs2wdJzkQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="128914560"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="128914560"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 00:04:14 -0700
IronPort-SDR: Q2mRak2UgfiLrg3sZxYOuh5J0y3GGbFbI2P9jkFn7i2q77yP2LA96pV7XI2Q2m/00uJqp6RVgw
 jDz7HsCXwj3w==
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="325755398"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 00:04:13 -0700
From:   ira.weiny@intel.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 07/15] Documentation/pkeys: Update documentation for kernel pkeys
Date:   Tue, 14 Jul 2020 00:02:12 -0700
Message-Id: <20200714070220.3500839-8-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200714070220.3500839-1-ira.weiny@intel.com>
References: <20200714070220.3500839-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Future Intel CPUS will support Protection Key Supervisor (PKS).

Update the protection key documentation to cover pkeys on supervisor
pages.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 Documentation/core-api/protection-keys.rst | 81 +++++++++++++++++-----
 1 file changed, 63 insertions(+), 18 deletions(-)

diff --git a/Documentation/core-api/protection-keys.rst b/Documentation/core-api/protection-keys.rst
index ec575e72d0b2..5ac400a5a306 100644
--- a/Documentation/core-api/protection-keys.rst
+++ b/Documentation/core-api/protection-keys.rst
@@ -4,25 +4,33 @@
 Memory Protection Keys
 ======================
 
-Memory Protection Keys for Userspace (PKU aka PKEYs) is a feature
-which is found on Intel's Skylake (and later) "Scalable Processor"
-Server CPUs. It will be available in future non-server Intel parts
-and future AMD processors.
-
-For anyone wishing to test or use this feature, it is available in
-Amazon's EC2 C5 instances and is known to work there using an Ubuntu
-17.04 image.
-
 Memory Protection Keys provides a mechanism for enforcing page-based
 protections, but without requiring modification of the page tables
-when an application changes protection domains.  It works by
-dedicating 4 previously ignored bits in each page table entry to a
-"protection key", giving 16 possible keys.
+when an application changes protection domains.
+
+PKeys Userspace (PKU) is a feature which is found on Intel's Skylake "Scalable
+Processor" Server CPUs and later.  And It will be available in future
+non-server Intel parts and future AMD processors.
+
+Future Intel processors will support Protection Keys for Supervisor pages
+(PKS).
+
+For anyone wishing to test or use user space pkeys, it is available in Amazon's
+EC2 C5 instances and is known to work there using an Ubuntu 17.04 image.
+
+pkes work by dedicating 4 previously Reserved bits in each page table entry to
+a "protection key", giving 16 possible keys.  User and Supervisor pages are
+treated separately.
 
-There is also a new user-accessible register (PKRU) with two separate
-bits (Access Disable and Write Disable) for each key.  Being a CPU
-register, PKRU is inherently thread-local, potentially giving each
-thread a different set of protections from every other thread.
+Protections for each page are controlled with per CPU registers for each type
+of page User and Supervisor.  Each of these 32 bit register stores two separate
+bits (Access Disable and Write Disable) for each key.
+
+For Userspace the register is user-accessible (rdpkru/wrpkru).  For
+Supervisor, the register (MSR_IA32_PKRS) is accessible only to the kernel.
+
+Being a CPU register, pkes are inherently thread-local, potentially giving
+each thread an independent set of protections from every other thread.
 
 There are two new instructions (RDPKRU/WRPKRU) for reading and writing
 to the new register.  The feature is only available in 64-bit mode,
@@ -30,8 +38,11 @@ even though there is theoretically space in the PAE PTEs.  These
 permissions are enforced on data access only and have no effect on
 instruction fetches.
 
-Syscalls
-========
+For kernel space rdmsr/wrmsr are used to access the kernel MSRs.
+
+
+Syscalls for user space keys
+============================
 
 There are 3 system calls which directly interact with pkeys::
 
@@ -98,3 +109,37 @@ with a read()::
 The kernel will send a SIGSEGV in both cases, but si_code will be set
 to SEGV_PKERR when violating protection keys versus SEGV_ACCERR when
 the plain mprotect() permissions are violated.
+
+
+Kernel API for PKS support
+==========================
+
+PKS is intended to harden against unwanted access to kernel pages.  But it does
+not completely restrict access under all conditions.  For example the MSR
+setting is not saved/restored during irqs.  Thus the use of PKS is a mitigation
+strategy rather than a form of strict security.
+
+The following calls are used to allocate, use, and deallocate a pkey which
+defines a 'protection domain' within the kernel.  Setting a pkey value in a
+supervisor mapping adds that mapping to the protection domain.  Then calls can be
+used to enable/disable read and/or write access to all of the pages mapped with
+that key:
+
+        int pks_key_alloc(const char * const pkey_user);
+        #define PAGE_KERNEL_PKEY(pkey)
+        #define _PAGE_KEY(pkey)
+        int pks_update_protection(int pkey, unsigned long protection);
+        void pks_key_free(int pkey);
+
+In-kernel users must be prepared to set PAGE_KERNEL_PKEY() permission in the
+page table entries for the mappings they want to ptorect.
+
+WARNING: It is imperative that callers check for errors from pks_key_alloc()
+because pkeys are a limited resource and so callers should be prepared to work
+without PKS support.
+
+For admins a debugfs interface provides a list of the current keys in use at:
+
+        /sys/kernel/debug/x86/pks_keys_allocated
+
+Some example code can be found in lib/pks/pks_test.c
-- 
2.25.1

