Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB2647E349
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 13:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348274AbhLWMbH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 07:31:07 -0500
Received: from mga14.intel.com ([192.55.52.115]:56928 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243475AbhLWMbH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 07:31:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640262667; x=1671798667;
  h=from:to:cc:subject:date:message-id;
  bh=B7UjJz2o8U/7WlNmnQCiNqRvJtB8Iir2uHf+buyKLjk=;
  b=WSUqVBKma5rIip212g1Wp0x7R3QUjklO8CYBEZ9Cn/WOaRHcXTGl+PEy
   ZO8g3yxOg09x71SNqAGzLx1LbyHmxFy+MF/lSKo38iLXQAd251oxDrZ3M
   3vDXtrcs8dW9q7ypGHAxSwcpVvYjoAxVsE4tLAh0KN5asgfYwLJ2OPx88
   YcWcuD79Nbhowmke8D+6xKS5xDMXkLvpe0Ff1vB2Mkr10m9r/5d1WlL0d
   EIrGteQvGWfboUXn8sVjztipABtreIFO45L2cYRgXcH8NwkqisixmRAZv
   6XAAdgH6BP0jqbU6e8w/L4A5cskOhZ/JkkGMcOnBUwfPVyaCWyQEeurtw
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="241040325"
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="241040325"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 04:30:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="522078427"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 23 Dec 2021 04:30:48 -0800
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
Subject: [PATCH v3 kvm/queue 00/16] KVM: mm: fd-based approach for supporting KVM guest private memory 
Date:   Thu, 23 Dec 2021 20:29:55 +0800
Message-Id: <20211223123011.41044-1-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the third version of this series which try to implement the
fd-based KVM guest private memory. Earlier this week I sent another v3 
version at link:

https://lore.kernel.org/linux-mm/20211222012223.GA22448@chaop.bj.intel.com/T/

That version is based on the latest TDX codebase. In contrast the one you
are reading is the same code rebased to latest kvm/queue branch at commit:

  c34c87a69727  KVM: x86: Update vPMCs when retiring branch instructions

There are some changes made to fit into the kvm queue branch but
generally the two versions are the same code in logic.

There is also difference in test. In the previous one I tested the new
private memory feature with TDX but in this rebased version I can not
test the new feature because lack TDX. I did run simple regression
test on this new version.

Introduction
------------
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
NOTE: below is the test for previous TDX based version. For this version
I only tested regular vm booting.

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
[1] Original design proposal:
https://lkml.kernel.org/kvm/20210824005248.200037-1-seanjc@google.com/
[2] Updated proposal and RFC patch v1:
https://lkml.kernel.org/linux-fsdevel/20211111141352.26311-1-chao.p.peng@linux.intel.com/
[3] RFC patch v2:
https://x-lore.kernel.org/qemu-devel/20211119134739.20218-1-chao.p.peng@linux.intel.com/

Chao Peng (14):
  mm/memfd: Introduce MFD_INACCESSIBLE flag
  KVM: Extend the memslot to support fd-based private memory
  KVM: Maintain ofs_tree for fast memslot lookup by file offset
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

 arch/x86/kvm/Kconfig           |   1 +
 arch/x86/kvm/mmu/mmu.c         | 120 ++++++++++++++-
 arch/x86/kvm/mmu/paging_tmpl.h |  11 +-
 arch/x86/kvm/x86.c             |   2 +-
 include/linux/kvm_host.h       |  43 +++++-
 include/linux/memfd.h          |  22 +++
 include/linux/shmem_fs.h       |  16 ++
 include/uapi/linux/fcntl.h     |   1 +
 include/uapi/linux/kvm.h       |  27 ++++
 include/uapi/linux/memfd.h     |   1 +
 mm/Kconfig                     |   4 +
 mm/memfd.c                     |  33 ++++-
 mm/shmem.c                     | 195 +++++++++++++++++++++++-
 virt/kvm/Makefile.kvm          |   2 +-
 virt/kvm/kvm_main.c            | 262 +++++++++++++++++++++++++--------
 virt/kvm/memfd.c               |  95 ++++++++++++
 16 files changed, 753 insertions(+), 82 deletions(-)
 create mode 100644 virt/kvm/memfd.c

-- 
2.17.1

