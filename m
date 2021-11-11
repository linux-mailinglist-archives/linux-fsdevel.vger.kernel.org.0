Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4853B44D7EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Nov 2021 15:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbhKKORk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Nov 2021 09:17:40 -0500
Received: from mga09.intel.com ([134.134.136.24]:49592 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230177AbhKKORk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Nov 2021 09:17:40 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="232759547"
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="scan'208";a="232759547"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 06:14:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,226,1631602800"; 
   d="scan'208";a="492555222"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga007.jf.intel.com with ESMTP; 11 Nov 2021 06:14:41 -0800
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
Subject: [RFC PATCH 0/6] KVM: mm: fd-based approach for supporting KVM guest private memory
Date:   Thu, 11 Nov 2021 22:13:39 +0800
Message-Id: <20211111141352.26311-1-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This RFC series try to implement the fd-based KVM guest private memory
proposal described at [1].

We had some offline discussions on this series already and that results
a different design proposal from Paolo. This thread includes both the
original RFC patch series for proposal [1] as well as the summary for
the new proposal from Paolo so that we can continue the discussion.

To understand the patch and the new proposal you are highly recommended
to read the original proposal [1] firstly.
 

Patch Description
=================
The patch include a private memory implementation in memfd/shmem backing
store and KVM support for private memory slot as well its counterpart in
QEMU.

Patch1:     kernel part shmem/memfd support
Patch2-6:   KVM part
Patch7-13:  QEMU part

QEMU Usage:
-machine private-memory-backend=ram1 \                                                                                                                                                                                       
-object memory-backend-memfd,id=ram1,size=5G,guest_private=on,seal=off


New Proposal
============
Below is a summary of the changes for the new proposal that was discussed
in the offline thread.

In general, this new proposal reuses the concept of fd-based guest
memory backing store that described in [1] but uses a different way to
coordinate the private and shared parts into one single memslot instead
of introducing dedicated private memslot.

- memslot extension
The new proposal suggests to add the private fd and the offset to
existing 'shared' memslot so both private/shared memory can live in one
single memslot. A page in the memslot is either private or shared. A
page is private only when it's allocated in the private fd, all the
other cases it's treated as shared, this includes those already mapped
as shared as well as those having not been mapped.

- private memory map/unmap
Userspace's map/unmap operations are done by fallocate() ioctl on
private fd.
  - map: default fallocate() with mode=0.
  - unmap: fallocate() with FALLOC_FL_PUNCH_HOLE.

There would be two new callbacks registered by KVM and called by memory
backing store during above map/unmap operations:
  - map(inode, offset, size): memory backing store to tell related KVM
    memslot to do a shared->private conversion.
  - unmap(inode, offset, size): memory backing store to tell related KVM
    memslot to do a private->shared conversion.

Memory backing store also needs to provide a new callback for KVM to
query if a page is already allocated in private-fd so KVM can know if
the page is private or not.
  - page_allocated(inode, offset): for shmem this would simply return
    pagecache_get_page().

There are two places in KVM that can exit to userspace to trigger
private/share conversion:
  - explicit conversion: happens when guest calls into KVM to explicitly
    map a range(as private or shared), KVM then exits to userspace to do
    the above map/unmap operations.
  - implicit conversion: happens in KVM page fault handler.
    * if fault due to a private memory access then cause a userspace exit
      for a shared->private conversion request when page_allocate() return
      false, otherwise map that directly without usrspace exit.
    * If fault due to a shared memory access then cause a userspace exit
      for a private->shared conversion request when page_allocate() return
      true, otherwise map that directly without userspace exit.
 
An example flow:

  guest                     Linux                userspace
  ------------------------- -------------------- -----------------------
                                                 ioctl(KVM_RUN)
  access private memoryd
         '--- EPT violation --.
                              v
                            userspace exit
                                 '------------------.
                                                    v
                                                 munmap shared memfd
                                                 fallocate private memfd
                                 .------------------'
                                 v
                            fallocate()
                              call guest_ops
                                 unmap shared PTE
                                 map private PTE
                              ...
                                                 ioctl(KVM_RUN)

Compared to the original proposal:
 - no need to introduce KVM memslot hole punching API,
 - would avoid potential memslot performance/scalability/fragment issue,
 - may also reduce userspace complexity,
 - but requires additional callbacks between KVM and memory backing
   store.

[1] https://lkml.kernel.org/kvm/51a6f74f-6c05-74b9-3fd7-b7cd900fb8cc@redhat.com/t/

Thanks,
Chao
---
Chao Peng (6):
  mm: Add F_SEAL_GUEST to shmem/memfd
  kvm: x86: Introduce guest private memory address space to memslot
  kvm: x86: add private_ops to memslot
  kvm: x86: implement private_ops for memfd backing store
  kvm: x86: add KVM_EXIT_MEMORY_ERROR exit
  KVM: add KVM_SPLIT_MEMORY_REGION

 Documentation/virt/kvm/api.rst  |   1 +
 arch/x86/include/asm/kvm_host.h |   5 +-
 arch/x86/include/uapi/asm/kvm.h |   4 +
 arch/x86/kvm/Makefile           |   2 +-
 arch/x86/kvm/memfd.c            |  63 +++++++++++
 arch/x86/kvm/mmu/mmu.c          |  69 ++++++++++--
 arch/x86/kvm/mmu/paging_tmpl.h  |   3 +-
 arch/x86/kvm/x86.c              |   3 +-
 include/linux/kvm_host.h        |  41 ++++++-
 include/linux/memfd.h           |  22 ++++
 include/linux/shmem_fs.h        |   9 ++
 include/uapi/linux/fcntl.h      |   1 +
 include/uapi/linux/kvm.h        |  34 ++++++
 mm/memfd.c                      |  34 +++++-
 mm/shmem.c                      | 127 +++++++++++++++++++++-
 virt/kvm/kvm_main.c             | 185 +++++++++++++++++++++++++++++++-
 16 files changed, 581 insertions(+), 22 deletions(-)
 create mode 100644 arch/x86/kvm/memfd.c

-- 
2.17.1

