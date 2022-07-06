Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39BC56811B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jul 2022 10:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbiGFIYD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jul 2022 04:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbiGFIXr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:23:47 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1C91AA;
        Wed,  6 Jul 2022 01:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657095826; x=1688631826;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FWiAIAa7c3qPCL55+mfI1NmiKsFRFBAYmL4Eb5t9uSo=;
  b=KPlIlx4n/PbOOHCbSLjXPiKiTO6r6M38T/A9Rx2+CVwhcqjPBGXVBnXw
   5bv2MTQ9wY0CcT9S7DJsZS/FFw5zMnvbql58gcrj4Fhs2yCKo/ehDAPXr
   ax1IQSiNUbomTJBMnhrtC8E1Yys9QM3pubo4Uq5r9U0DFwl9Qr8xcaNN0
   AC3FUd5sWambEifo6Kp11ovtiRrDFY+LbUkjrNArPeWZj0ZPUWtDa15KM
   1pFvBC8/MiCDKmSvsQnpy1cULmvza+7L/BAjZdVqu1wOfGzztLAfT6rtD
   1aUyt0IVkwRI+zQfre0o+68kaqtcwecTWpELG64NyDTQ24zP/xGgiiB/O
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="281231747"
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="281231747"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 01:23:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,249,1650956400"; 
   d="scan'208";a="567967808"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga006.jf.intel.com with ESMTP; 06 Jul 2022 01:23:34 -0700
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        qemu-devel@nongnu.org, linux-kselftest@vger.kernel.org
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
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM guest private memory 
Date:   Wed,  6 Jul 2022 16:20:02 +0800
Message-Id: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the v7 of this series which tries to implement the fd-based KVM
guest private memory. The patches are based on latest kvm/queue branch
commit:

  b9b71f43683a (kvm/queue) KVM: x86/mmu: Buffer nested MMU
split_desc_cache only by default capacity

Introduction
------------
In general this patch series introduce fd-based memslot which provides
guest memory through memory file descriptor fd[offset,size] instead of
hva/size. The fd can be created from a supported memory filesystem
like tmpfs/hugetlbfs etc. which we refer as memory backing store. KVM
and the the memory backing store exchange callbacks when such memslot
gets created. At runtime KVM will call into callbacks provided by the
backing store to get the pfn with the fd+offset. Memory backing store
will also call into KVM callbacks when userspace punch hole on the fd
to notify KVM to unmap secondary MMU page table entries.

Comparing to existing hva-based memslot, this new type of memslot allows
guest memory unmapped from host userspace like QEMU and even the kernel
itself, therefore reduce attack surface and prevent bugs.

Based on this fd-based memslot, we can build guest private memory that
is going to be used in confidential computing environments such as Intel
TDX and AMD SEV. When supported, the memory backing store can provide
more enforcement on the fd and KVM can use a single memslot to hold both
the private and shared part of the guest memory. 

mm extension
---------------------
Introduces new MFD_INACCESSIBLE flag for memfd_create(), the file
created with these flags cannot read(), write() or mmap() etc via normal
MMU operations. The file content can only be used with the newly
introduced memfile_notifier extension.

The memfile_notifier extension provides two sets of callbacks for KVM to
interact with the memory backing store:
  - memfile_notifier_ops: callbacks for memory backing store to notify
    KVM when memory gets invalidated.
  - backing store callbacks: callbacks for KVM to call into memory
    backing store to request memory pages for guest private memory.

The memfile_notifier extension also provides APIs for memory backing
store to register/unregister itself and to trigger the notifier when the
bookmarked memory gets invalidated.

The patchset also introduces a new memfd seal F_SEAL_AUTO_ALLOCATE to
prevent double allocation caused by unintentional guest when we only
have a single side of the shared/private memfds effective.

memslot extension
-----------------
Add the private fd and the fd offset to existing 'shared' memslot so
that both private/shared guest memory can live in one single memslot.
A page in the memslot is either private or shared. Whether a guest page
is private or shared is maintained through reusing existing SEV ioctls
KVM_MEMORY_ENCRYPT_{UN,}REG_REGION.

Test
----
To test the new functionalities of this patch TDX patchset is needed.
Since TDX patchset has not been merged so I did two kinds of test:

-  Regresion test on kvm/queue (this patchset)
   Most new code are not covered. Code also in below repo:
   https://github.com/chao-p/linux/tree/privmem-v7

-  New Funational test on latest TDX code
   The patch is rebased to latest TDX code and tested the new
   funcationalities. See below repos:
   Linux: https://github.com/chao-p/linux/tree/privmem-v7-tdx
   QEMU: https://github.com/chao-p/qemu/tree/privmem-v7

An example QEMU command line for TDX test:
-object tdx-guest,id=tdx,debug=off,sept-ve-disable=off \
-machine confidential-guest-support=tdx \
-object memory-backend-memfd-private,id=ram1,size=${mem} \
-machine memory-backend=ram1

Changelog
----------
v7:
  - Move the private/shared info from backing store to KVM.
  - Introduce F_SEAL_AUTO_ALLOCATE to avoid double allocation.
  - Rework on the sync mechanism between zap/page fault paths.
  - Addressed other comments in v6.
v6:
  - Re-organzied patch for both mm/KVM parts.
  - Added flags for memfile_notifier so its consumers can state their
    features and memory backing store can check against these flags.
  - Put a backing store reference in the memfile_notifier and move pfn_ops
    into backing store.
  - Only support boot time backing store register.
  - Overall KVM part improvement suggested by Sean and some others.
v5:
  - Removed userspace visible F_SEAL_INACCESSIBLE, instead using an
    in-kernel flag (SHM_F_INACCESSIBLE for shmem). Private fd can only
    be created by MFD_INACCESSIBLE.
  - Introduced new APIs for backing store to register itself to
    memfile_notifier instead of direct function call.
  - Added the accounting and restriction for MFD_INACCESSIBLE memory.
  - Added KVM API doc for new memslot extensions and man page for the new
    MFD_INACCESSIBLE flag.
  - Removed the overlap check for mapping the same file+offset into
    multiple gfns due to perf consideration, warned in document.
  - Addressed other comments in v4.
v4:
  - Decoupled the callbacks between KVM/mm from memfd and use new
    name 'memfile_notifier'.
  - Supported register multiple memslots to the same backing store.
  - Added per-memslot pfn_ops instead of per-system.
  - Reworked the invalidation part.
  - Improved new KVM uAPIs (private memslot extension and memory
    error) per Sean's suggestions.
  - Addressed many other minor fixes for comments from v3.
v3:
  - Added locking protection when calling
    invalidate_page_range/fallocate callbacks.
  - Changed memslot structure to keep use useraddr for shared memory.
  - Re-organized F_SEAL_INACCESSIBLE and MEMFD_OPS.
  - Added MFD_INACCESSIBLE flag to force F_SEAL_INACCESSIBLE.
  - Commit message improvement.
  - Many small fixes for comments from the last version.

Links to previous discussions
-----------------------------
[1] Original design proposal:
https://lkml.kernel.org/kvm/20210824005248.200037-1-seanjc@google.com/
[2] Updated proposal and RFC patch v1:
https://lkml.kernel.org/linux-fsdevel/20211111141352.26311-1-chao.p.peng@linux.intel.com/
[3] Patch v5: https://lkml.org/lkml/2022/5/19/861

Chao Peng (12):
  mm: Add F_SEAL_AUTO_ALLOCATE seal to memfd
  selftests/memfd: Add tests for F_SEAL_AUTO_ALLOCATE
  mm: Introduce memfile_notifier
  mm/memfd: Introduce MFD_INACCESSIBLE flag
  KVM: Rename KVM_PRIVATE_MEM_SLOTS to KVM_INTERNAL_MEM_SLOTS
  KVM: Use gfn instead of hva for mmu_notifier_retry
  KVM: Rename mmu_notifier_*
  KVM: Extend the memslot to support fd-based private memory
  KVM: Add KVM_EXIT_MEMORY_FAULT exit
  KVM: Register/unregister the guest private memory regions
  KVM: Handle page fault for private memory
  KVM: Enable and expose KVM_MEM_PRIVATE

Kirill A. Shutemov (1):
  mm/shmem: Support memfile_notifier

 Documentation/virt/kvm/api.rst             |  77 +++++-
 arch/arm64/kvm/mmu.c                       |   8 +-
 arch/mips/include/asm/kvm_host.h           |   2 +-
 arch/mips/kvm/mmu.c                        |  10 +-
 arch/powerpc/include/asm/kvm_book3s_64.h   |   2 +-
 arch/powerpc/kvm/book3s_64_mmu_host.c      |   4 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c        |   4 +-
 arch/powerpc/kvm/book3s_64_mmu_radix.c     |   6 +-
 arch/powerpc/kvm/book3s_hv_nested.c        |   2 +-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c        |   8 +-
 arch/powerpc/kvm/e500_mmu_host.c           |   4 +-
 arch/riscv/kvm/mmu.c                       |   4 +-
 arch/x86/include/asm/kvm_host.h            |   3 +-
 arch/x86/kvm/Kconfig                       |   3 +
 arch/x86/kvm/mmu.h                         |   2 -
 arch/x86/kvm/mmu/mmu.c                     |  74 +++++-
 arch/x86/kvm/mmu/mmu_internal.h            |  18 ++
 arch/x86/kvm/mmu/mmutrace.h                |   1 +
 arch/x86/kvm/mmu/paging_tmpl.h             |   4 +-
 arch/x86/kvm/x86.c                         |   2 +-
 include/linux/kvm_host.h                   | 105 +++++---
 include/linux/memfile_notifier.h           |  91 +++++++
 include/linux/shmem_fs.h                   |   2 +
 include/uapi/linux/fcntl.h                 |   1 +
 include/uapi/linux/kvm.h                   |  37 +++
 include/uapi/linux/memfd.h                 |   1 +
 mm/Kconfig                                 |   4 +
 mm/Makefile                                |   1 +
 mm/memfd.c                                 |  18 +-
 mm/memfile_notifier.c                      | 123 ++++++++++
 mm/shmem.c                                 | 125 +++++++++-
 tools/testing/selftests/memfd/memfd_test.c | 166 +++++++++++++
 virt/kvm/Kconfig                           |   3 +
 virt/kvm/kvm_main.c                        | 272 ++++++++++++++++++---
 virt/kvm/pfncache.c                        |  14 +-
 35 files changed, 1074 insertions(+), 127 deletions(-)
 create mode 100644 include/linux/memfile_notifier.h
 create mode 100644 mm/memfile_notifier.c

-- 
2.25.1

