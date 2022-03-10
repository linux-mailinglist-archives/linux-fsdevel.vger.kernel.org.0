Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF96A4D48A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 15:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242693AbiCJOKi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 09:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234624AbiCJOKh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:10:37 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD6457499;
        Thu, 10 Mar 2022 06:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646921376; x=1678457376;
  h=from:to:cc:subject:date:message-id;
  bh=qOgHsb0TerXs6BotdtqnRubNe5gkoi8JAE7y4owcZNM=;
  b=VZlo9WvZcFU4DH2iqp1IjB67PABnlJsF9QhgcCF6EcBm3VDewb1X0B0+
   W8WI3OVfW/mhp7Wg5eD2/hbKcuzjTtQPJtC789aDwv8GdPElk+sMGUsZS
   vURPkq1sobN1O6AWYxOvpC+9gS2zL4h0I/K1GskaALPljzgLjEciH8QNO
   44yp4iUSaYRzC3lARrk6qo26GOqKoiBe+LrIH/4oQl1otVB5PMCMHDa2m
   2+dOC/INdY3M4GD8XyqY8a8vM3oXKg1UHPlMoeF2qO9UmGeYf54TjCGg9
   6t6jUGArYu78iuBvyF9OPbpe592icTlZp4R+JvY5L/Sa2+qLertW6jvsI
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="242702393"
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="242702393"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 06:09:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,170,1643702400"; 
   d="scan'208";a="554654744"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 10 Mar 2022 06:09:27 -0800
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
Subject: [PATCH v5 00/13] KVM: mm: fd-based approach for supporting KVM guest private memory 
Date:   Thu, 10 Mar 2022 22:08:58 +0800
Message-Id: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the v5 of this series which tries to implement the fd-based KVM
guest private memory. The patches are based on latest kvm/queue branch
commit:

  d5089416b7fb KVM: x86: Introduce KVM_CAP_DISABLE_QUIRKS2
 
Introduction
------------
In general this patch series introduce fd-based memslot which provides
guest memory through memory file descriptor fd[offset,size] instead of
hva/size. The fd can be created from a supported memory filesystem
like tmpfs/hugetlbfs etc. which we refer as memory backing store. KVM
and the the memory backing store exchange callbacks when such memslot
gets created. At runtime KVM will call into callbacks provided by the
backing store to get the pfn with the fd+offset. Memory backing store
will also call into KVM callbacks when userspace fallocate/punch hole
on the fd to notify KVM to map/unmap secondary MMU page tables.

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
Introduces new MFD_INACCESSIBLE flag for memfd_create(), the file created
with these flags cannot read(), write() or mmap() etc via normal
MMU operations. The file content can only be used with the newly
introduced memfile_notifier extension.

The memfile_notifier extension provides two sets of callbacks for KVM to
interact with the memory backing store:
  - memfile_notifier_ops: callbacks for memory backing store to notify
    KVM when memory gets allocated/invalidated.
  - memfile_pfn_ops: callbacks for KVM to call into memory backing store
    to request memory pages for guest private memory.

The memfile_notifier extension also provides APIs for memory backing
store to register/unregister itself and to trigger the notifier when the
bookmarked memory gets fallocated/invalidated.

memslot extension
-----------------
Add the private fd and the fd offset to existing 'shared' memslot so that
both private/shared guest memory can live in one single memslot. A page in
the memslot is either private or shared. A page is private only when it's
already allocated in the backing store fd, all the other cases it's treated
as shared, this includes those already mapped as shared as well as those
having not been mapped. This means the memory backing store is the place
which tells the truth of which page is private.

Private memory map/unmap and conversion
---------------------------------------
Userspace's map/unmap operations are done by fallocate() ioctl on the
backing store fd.
  - map: default fallocate() with mode=0.
  - unmap: fallocate() with FALLOC_FL_PUNCH_HOLE.
The map/unmap will trigger above memfile_notifier_ops to let KVM map/unmap
secondary MMU page tables.

Test
----
To test the new functionalities of this patch TDX patchset is needed.
Since TDX patchset has not been merged so I did two kinds of test:

-  Regresion test on kvm/queue (this patch)
   Most new code are not covered. I only tested building and booting.

-  New Funational test on latest TDX code
   The patch is rebased to latest TDX code and tested the new
   funcationalities.

For TDX test please see below repos:
Linux: https://github.com/chao-p/linux/tree/privmem-v5.1
QEMU: https://github.com/chao-p/qemu/tree/privmem-v4

And an example QEMU command line:
-object tdx-guest,id=tdx \
-object memory-backend-memfd-private,id=ram1,size=2G \
-machine q35,kvm-type=tdx,pic=no,kernel_irqchip=split,memory-encryption=tdx,memory-backend=ram1

Changelog
----------
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
[3] Patch v4: https://lkml.org/lkml/2022/1/18/395

Chao Peng (10):
  mm: Introduce memfile_notifier
  mm/shmem: Restrict MFD_INACCESSIBLE memory against RLIMIT_MEMLOCK
  KVM: Extend the memslot to support fd-based private memory
  KVM: Use kvm_userspace_memory_region_ext
  KVM: Add KVM_EXIT_MEMORY_ERROR exit
  KVM: Use memfile_pfn_ops to obtain pfn for private pages
  KVM: Handle page fault for private memory
  KVM: Register private memslot to memory backing store
  KVM: Zap existing KVM mappings when pages changed in the private fd
  KVM: Expose KVM_MEM_PRIVATE

Kirill A. Shutemov (2):
  mm/memfd: Introduce MFD_INACCESSIBLE flag
  mm/shmem: Support memfile_notifier

 Documentation/virt/kvm/api.rst   |  59 +++++++++--
 arch/x86/kvm/Kconfig             |   1 +
 arch/x86/kvm/mmu/mmu.c           |  73 +++++++++++++-
 arch/x86/kvm/mmu/paging_tmpl.h   |  11 ++-
 arch/x86/kvm/x86.c               |  12 +--
 include/linux/kvm_host.h         |  49 ++++++++-
 include/linux/memfile_notifier.h |  64 ++++++++++++
 include/linux/shmem_fs.h         |  11 +++
 include/uapi/linux/kvm.h         |  17 ++++
 include/uapi/linux/memfd.h       |   1 +
 mm/Kconfig                       |   4 +
 mm/Makefile                      |   1 +
 mm/memfd.c                       |  26 ++++-
 mm/memfile_notifier.c            | 114 +++++++++++++++++++++
 mm/shmem.c                       | 156 +++++++++++++++++++++++++++++
 virt/kvm/kvm_main.c              | 165 +++++++++++++++++++++++++++----
 16 files changed, 717 insertions(+), 47 deletions(-)
 create mode 100644 include/linux/memfile_notifier.h
 create mode 100644 mm/memfile_notifier.c

-- 
2.17.1

