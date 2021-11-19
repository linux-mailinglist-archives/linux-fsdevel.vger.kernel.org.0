Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163B5456FE4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 14:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbhKSNvh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Nov 2021 08:51:37 -0500
Received: from mga12.intel.com ([192.55.52.136]:23750 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235554AbhKSNvg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Nov 2021 08:51:36 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="214443809"
X-IronPort-AV: E=Sophos;i="5.87,247,1631602800"; 
   d="scan'208";a="214443809"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 05:48:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,247,1631602800"; 
   d="scan'208";a="507904726"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 19 Nov 2021 05:48:26 -0800
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
Subject: [RFC v2 PATCH 00/13] KVM: mm: fd-based approach for supporting KVM guest private memory
Date:   Fri, 19 Nov 2021 21:47:26 +0800
Message-Id: <20211119134739.20218-1-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This RFC series try to implement the fd-based KVM guest private memory
proposal described at [1] and an improved 'New Proposal' described at [2].

In general this patch series introduce fd-based memslot which provide
guest memory through fd[offset,size] instead of hva/size. The fd then
can be created from a supported memory filesystem like tmpfs/hugetlbfs,
etc which we refer as memory backing store. KVM and backing store
exchange some callbacks when such memslot gets created. At runtime KVM
will call into callbacks provided by backing store to get the pfn with
the fd+offset. Backing store will also call into KVM callbacks when
userspace fallocate/punch hole on fd to notify KVM to map/unmap second
MMU page tables.

Comparing to existing hva-based memslot, this new type of memslot allow
guest memory unmapped from host userspace like QEMU and even the kernel
itself, therefore reduce attack surface and bring some other benefits. 

Based on this fd-based memslot, we can build guest private memory that
is going to be used in confidential computing environments such as Intel
TDX and AMD SEV. When supported, the backing store can provide more
enforcement on the fd and KVM can use a single memslot to hold both
private and shared part of the guest memory. For more detailed
description please refer to [2].

Because this design introducing some callbacks between memory backing
store and KVM, and for private memory KVM relies on backing store to do
additonal enforcement and to tell if a address is private or shared,
I would like KVM/mm/fs people can have a look at this part.


[1]
https://lkml.kernel.org/kvm/51a6f74f-6c05-74b9-3fd7-b7cd900fb8cc@redhat.com/
[2]
https://lkml.kernel.org/linux-fsdevel/20211111141352.26311-1-chao.p.peng@linux.intel.com/

Thanks,
Chao
---
Chao Peng (12):
  KVM: Add KVM_EXIT_MEMORY_ERROR exit
  KVM: Extend kvm_userspace_memory_region to support fd based memslot
  KVM: Add fd-based memslot data structure and utils
  KVM: Implement fd-based memory using new memfd interfaces
  KVM: Register/unregister memfd backed memslot
  KVM: Handle page fault for fd based memslot
  KVM: Rename hva memory invalidation code to cover fd-based offset
  KVM: Introduce kvm_memfd_invalidate_range
  KVM: Match inode for invalidation of fd-based slot
  KVM: Add kvm_map_gfn_range
  KVM: Introduce kvm_memfd_fallocate_range
  KVM: Enable memfd based page invalidation/fallocate

Kirill A. Shutemov (1):
  mm/shmem: Introduce F_SEAL_GUEST

 arch/arm64/kvm/mmu.c               |  14 +--
 arch/mips/kvm/mips.c               |  14 +--
 arch/powerpc/include/asm/kvm_ppc.h |  28 ++---
 arch/powerpc/kvm/book3s.c          |  14 +--
 arch/powerpc/kvm/book3s_hv.c       |  14 +--
 arch/powerpc/kvm/book3s_pr.c       |  14 +--
 arch/powerpc/kvm/booke.c           |  14 +--
 arch/powerpc/kvm/powerpc.c         |  14 +--
 arch/riscv/kvm/mmu.c               |  14 +--
 arch/s390/kvm/kvm-s390.c           |  14 +--
 arch/x86/include/asm/kvm_host.h    |   6 +-
 arch/x86/kvm/Makefile              |   3 +-
 arch/x86/kvm/mmu/mmu.c             | 122 ++++++++++++++++++++-
 arch/x86/kvm/vmx/main.c            |   6 +-
 arch/x86/kvm/vmx/tdx.c             |   6 +-
 arch/x86/kvm/vmx/tdx_stubs.c       |   6 +-
 arch/x86/kvm/x86.c                 |  16 +--
 include/linux/kvm_host.h           |  58 ++++++++--
 include/linux/memfd.h              |  24 +++++
 include/linux/shmem_fs.h           |   9 ++
 include/uapi/linux/fcntl.h         |   1 +
 include/uapi/linux/kvm.h           |  27 +++++
 mm/memfd.c                         |  33 +++++-
 mm/shmem.c                         | 123 ++++++++++++++++++++-
 virt/kvm/kvm_main.c                | 165 +++++++++++++++++++++++------
 virt/kvm/memfd.c                   | 123 +++++++++++++++++++++
 26 files changed, 733 insertions(+), 149 deletions(-)
 create mode 100644 virt/kvm/memfd.c

-- 
2.17.1

