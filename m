Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A1A47C24D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 16:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238985AbhLUPMM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 10:12:12 -0500
Received: from mga18.intel.com ([134.134.136.126]:45583 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238974AbhLUPML (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:12:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640099531; x=1671635531;
  h=from:to:cc:subject:date:message-id;
  bh=bhiBZIBPUvq8tNjFZYJrVCRkahxll9ZU4gU5+TYg0gQ=;
  b=ZC5NfSsf31t7XUFVAFX+QIMUdFZH2+blNulPZ7um0g5ji4P4jq0UhjxF
   bn5e9YfbY+fssBdtx8RM/3orIDI0Jfu5Qpiwh45hbZ7uckpgzOL0/AsYZ
   CN+rZZpQc0+/oI+ZG4Or/nBP8N1o7ceNsY1atlpkUhHwZgdaaB8TlAoBy
   NAzaGAUJcJscn7tlAoZ6cFZ3/cRQOsHxIKsYu5Eu8tdG+ZfD9ZGNWBg8F
   v+nw/Qz0oDTyoyNe3Gen+BHcYsBxn9/+SPe4GIchK3Act9pKMgiTT9t4f
   4WjmpzWu44uAnD6RzRRbZrleuK9phCMdBRl9gxv+Fd+wPPQlKIm9mLJ1d
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="227259260"
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="227259260"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 07:12:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="684688254"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga005.jf.intel.com with ESMTP; 21 Dec 2021 07:12:03 -0800
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
Subject: [PATCH v3 00/15] KVM: mm: fd-based approach for supporting KVM guest private memory 
Date:   Tue, 21 Dec 2021 23:11:10 +0800
Message-Id: <20211221151125.19446-1-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the third version of this series which try to implement the
fd-based KVM guest private memory.

In general this patch series introduce fd-based memslot which provide
guest memory through a memfd file descriptor fd[offset,size] instead of
hva/size. The fd then can be created from a supported memory filesystem
like tmpfs/hugetlbfs etc which we refer as memory backend. KVM and the
memory backend exchange some callbacks when such memslot gets created.
At runtime KVM will call into callbacks provided by backend to get the
pfn with the fd+offset. Memory backend will also call into KVM callbacks
when userspace fallocate/punch hole on the fd to notify KVM to map/unmap
secondary MMU page tables.

Comparing to existing hva-based memslot, this new type of memslot allow
guest memory unmapped from host userspace like QEMU and even the kernel
itself, therefore reduce attack surface and prevent userspace bugs.

Based on this fd-based memslot, we can build guest private memory that
is going to be used in confidential computing environments such as Intel
TDX and AMD SEV. When supported, the memory backend can provide more
enforcement on the fd and KVM can use a single memslot to hold both the
private and shared part of the guest memory. 

Memfd/shmem extension
---------------------
Introduces new MFD_INACCESSIBLE flag for memfd_create(), the file
created with this flag cannot read(), write() or mmap() etc.

In addition, two sets of callbacks are introduced as new MEMFD_OPS:
  - memfd_falloc_notifier: memfd -> KVM notifier when memory gets
    allocated/invalidated through fallocate().
  - memfd_pfn_ops: kvm -> memfd to get a pfn with the fd+offset.

Memslot extension
-----------------
Add the private fd and the offset into the fd to existing 'shared' memslot
so that both private/shared guest memory can live in one single memslot.
A page in the memslot is either private or shared. A page is private only
when it's already allocated in the backend fd, all the other cases it's
treated as shared, this includes those already mapped as shared as well as
those having not been mapped. This means the memory backend is the place
which tells the truth of which page is private.

Private memory map/unmap and conversion
---------------------------------------
Userspace's map/unmap operations are done by fallocate() ioctl on the
backend fd.
  - map: default fallocate() with mode=0.
  - unmap: fallocate() with FALLOC_FL_PUNCH_HOLE.
The map/unmap will trigger above memfd_falloc_notifier to let KVM
map/unmap second MMU page tables.

Test
----
This code has been tested with latest TDX code patches hosted at
(https://github.com/intel/tdx/tree/kvm-upstream) with minimal TDX
adaption and QEMU support.

Example QEMU command line:
-object tdx-guest,id=tdx \
-object memory-backend-memfd-private,id=ram1,size=2G \
-machine q35,kvm-type=tdx,pic=no,kernel_irqchip=split,memory-encryption=tdx,memory-backend=ram1

Changelog
----------
v3:
  - Added locking protection when calling
    invalidate_page_range/fallocate callbacks.
  - Changed memslot structure to keep use useraddr for shared memory.
  - Re-organized F_SEAL_INACCESSIBLE and MEMFD_OPS.
  - Added MFD_INACCESSIBLE flag to force F_SEAL_INACCESSIBLE.
  - Commit message improvement.
  - Many small fixes for comments from the last version.

Links of previous discussions
-----------------------------
[1]
https://lkml.kernel.org/kvm/51a6f74f-6c05-74b9-3fd7-b7cd900fb8cc@redhat.com/
[2]
https://lkml.kernel.org/linux-fsdevel/20211111141352.26311-1-chao.p.peng@linux.intel.com/


Chao Peng (13):
  mm/memfd: Introduce MFD_INACCESSIBLE flag
  KVM: Extend the memslot to support fd-based private memory
  KVM: Implement fd-based memory using MEMFD_OPS interfaces
  KVM: Refactor hva based memory invalidation code
  KVM: Special handling for fd-based memory invalidation
  KVM: Split out common memory invalidation code
  KVM: Implement fd-based memory invalidation
  KVM: Add kvm_map_gfn_range
  KVM: Implement fd-based memory fallocation
  KVM: Add KVM_EXIT_MEMORY_ERROR exit
  KVM: Handle page fault for private memory
  KVM: Use kvm_userspace_memory_region_ext
  KVM: Register/unregister private memory slot to memfd

Kirill A. Shutemov (2):
  mm/shmem: Introduce F_SEAL_INACCESSIBLE
  mm/memfd: Introduce MEMFD_OPS

 arch/arm64/kvm/mmu.c               |  14 +-
 arch/mips/kvm/mips.c               |  14 +-
 arch/powerpc/include/asm/kvm_ppc.h |  28 ++--
 arch/powerpc/kvm/book3s.c          |  14 +-
 arch/powerpc/kvm/book3s_hv.c       |  14 +-
 arch/powerpc/kvm/book3s_pr.c       |  14 +-
 arch/powerpc/kvm/booke.c           |  14 +-
 arch/powerpc/kvm/powerpc.c         |  14 +-
 arch/riscv/kvm/mmu.c               |  14 +-
 arch/s390/kvm/kvm-s390.c           |  14 +-
 arch/x86/kvm/Kconfig               |   1 +
 arch/x86/kvm/Makefile              |   3 +-
 arch/x86/kvm/mmu/mmu.c             | 112 +++++++++++++-
 arch/x86/kvm/mmu/paging_tmpl.h     |  11 +-
 arch/x86/kvm/x86.c                 |  16 +-
 include/linux/kvm_host.h           |  57 +++++--
 include/linux/memfd.h              |  22 +++
 include/linux/shmem_fs.h           |  16 ++
 include/uapi/linux/fcntl.h         |   1 +
 include/uapi/linux/kvm.h           |  27 ++++
 include/uapi/linux/memfd.h         |   1 +
 mm/Kconfig                         |   4 +
 mm/memfd.c                         |  33 +++-
 mm/shmem.c                         | 195 ++++++++++++++++++++++-
 virt/kvm/kvm_main.c                | 239 +++++++++++++++++++++--------
 virt/kvm/memfd.c                   | 100 ++++++++++++
 26 files changed, 822 insertions(+), 170 deletions(-)
 create mode 100644 virt/kvm/memfd.c

-- 
2.17.1

