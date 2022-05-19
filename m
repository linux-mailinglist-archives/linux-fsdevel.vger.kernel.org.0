Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D9552D800
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 17:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241486AbiESPmW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 11:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241142AbiESPkx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 11:40:53 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE7410C3;
        Thu, 19 May 2022 08:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652974851; x=1684510851;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2gQabxIn8tPmd6ZL9v/swSq/nd87q2Ez4Gvfaiq6P+g=;
  b=kGItLVNZA1Muqh7qEmRLz6D5HxVgDTFDh/PFFakiDGWodNSeDUjZ60Eb
   rO9UAZrU7zplGU/jb9rL4OPjAvtFRIUORzZl3mihAt68DxZ70VcPiUjRJ
   ylX1ZjWhLyzP/zvFesdPikivmi977YnYBKpWJ5Rl+2n4IwoUUZGvbkcFe
   hrD1qFdzAZ9ImtqdcJWZjaSPz3sObSMfSi88/tLtUBH5x9nj/qo00214x
   vo9Nz0tTsw4eta7zMaXFVslG2ISj8U8mZZBU2Vl9TKr5Q3JvhPjV7env1
   0b0wLsTMNzInRjHaRG6U2DrFe4vNm/vvr1XzvF2aGJ+EyOSWiUZhIzo+W
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="272377334"
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="272377334"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 08:40:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="598634928"
Received: from chaop.bj.intel.com ([10.240.192.101])
  by orsmga008.jf.intel.com with ESMTP; 19 May 2022 08:40:41 -0700
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
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
        Mike Rapoport <rppt@kernel.org>,
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
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com
Subject: [PATCH v6 0/8] KVM: mm: fd-based approach for supporting KVM guest private memory 
Date:   Thu, 19 May 2022 23:37:05 +0800
Message-Id: <20220519153713.819591-1-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the v6 of this series which tries to implement the fd-based KVM
guest private memory. The patches are based on latest kvm/queue branch
commit:

  2764011106d0 (kvm/queue) KVM: VMX: Include MKTME KeyID bits in
shadow_zero_check
 
and Sean's below patch:

  KVM: x86/mmu: Add RET_PF_CONTINUE to eliminate bool+int* "returns"
  https://lkml.org/lkml/2022/4/22/1598

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
  - backing store callbacks: callbacks for KVM to call into memory backing
    store to request memory pages for guest private memory.

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

-  Selftest on normal VM from Vishal
   https://lkml.org/lkml/2022/5/10/2045
   The selftest has been ported to this patchset and you can find it in
   repo: https://github.com/chao-p/linux/tree/privmem-v6

-  Private memory funational test on latest TDX code
   The patch is rebased to latest TDX code and tested the new
   funcationalities. See below repos:
   Linux: https://github.com/chao-p/linux/commits/privmem-v6-tdx
   QEMU: https://github.com/chao-p/qemu/tree/privmem-v6

An example QEMU command line for TDX test:
-object tdx-guest,id=tdx \
-object memory-backend-memfd-private,id=ram1,size=2G \
-machine q35,kvm-type=tdx,pic=no,kernel_irqchip=split,memory-encryption=tdx,memory-backend=ram1

What's missing
--------------
  - The accounting for longterm pinned memory in the backing store is
    not included since I havn't come out a good solution yet.
  - Batch invalidation notify for shmem is not ready, as I still see
    it's a bit tricky to do that clearly.

Changelog
----------
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
[3] Patch v5: https://lkml.org/lkml/2022/3/10/457

Chao Peng (6):
  mm: Introduce memfile_notifier
  mm/memfd: Introduce MFD_INACCESSIBLE flag
  KVM: Extend the memslot to support fd-based private memory
  KVM: Add KVM_EXIT_MEMORY_FAULT exit
  KVM: Handle page fault for private memory
  KVM: Enable and expose KVM_MEM_PRIVATE

Kirill A. Shutemov (1):
  mm/shmem: Support memfile_notifier

 Documentation/virt/kvm/api.rst   |  60 ++++++++++--
 arch/mips/include/asm/kvm_host.h |   2 +-
 arch/x86/include/asm/kvm_host.h  |   2 +-
 arch/x86/kvm/Kconfig             |   2 +
 arch/x86/kvm/mmu.h               |   1 +
 arch/x86/kvm/mmu/mmu.c           |  70 +++++++++++++-
 arch/x86/kvm/mmu/mmu_internal.h  |  17 ++++
 arch/x86/kvm/mmu/mmutrace.h      |   1 +
 arch/x86/kvm/mmu/paging_tmpl.h   |   5 +-
 arch/x86/kvm/x86.c               |   2 +-
 include/linux/kvm_host.h         |  51 +++++++++--
 include/linux/memfile_notifier.h |  99 ++++++++++++++++++++
 include/linux/shmem_fs.h         |   2 +
 include/uapi/linux/kvm.h         |  33 +++++++
 include/uapi/linux/memfd.h       |   1 +
 mm/Kconfig                       |   4 +
 mm/Makefile                      |   1 +
 mm/memfd.c                       |  15 ++-
 mm/memfile_notifier.c            | 137 +++++++++++++++++++++++++++
 mm/shmem.c                       | 120 +++++++++++++++++++++++-
 virt/kvm/Kconfig                 |   3 +
 virt/kvm/kvm_main.c              | 153 +++++++++++++++++++++++++++++--
 22 files changed, 748 insertions(+), 33 deletions(-)
 create mode 100644 include/linux/memfile_notifier.h
 create mode 100644 mm/memfile_notifier.c

-- 
2.25.1

