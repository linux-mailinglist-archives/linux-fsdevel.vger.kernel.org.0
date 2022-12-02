Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986E164003B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Dec 2022 07:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbiLBGS3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Dec 2022 01:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbiLBGSW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Dec 2022 01:18:22 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80666CA78D;
        Thu,  1 Dec 2022 22:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669961900; x=1701497900;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9pJ+b2yeHo2LDdteBDTW1h9o4MtUauJFK7JJvjQzm24=;
  b=MNvrhzKNOrplFVQykiuUTNcXxgzJUPCy7yCTvXHYsdtxJbNVgmlLKBqu
   bZ5OEgUplhxs268MKTRgsgVtiUXhppeRC5GYXOiYsvn0nwHk6wjzTdySB
   Re6LL4NqYyilA2kQ7Uo+m6EKQgAuPVDU8spgy48YW1YH8ebzOHNtLNnDn
   qOkDVL6rm0YVeFvOUB761BXiEw1P9IGHH/xpGoDYiGsTDQ8NmlCz6ZcrD
   qZN0UZyWBWEyJ4UVOIRNvEC93nVLa157nCYFl7obqa8eW1+i9oaCyo0tc
   Bo0MblN5ZTUtHPYPtf+uoB134CrkMBD27elegcjg6mRrs28l2udN2JdsF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="380170336"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="380170336"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 22:18:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="733698561"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="733698561"
Received: from chaop.bj.intel.com ([10.240.193.75])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Dec 2022 22:18:08 -0800
From:   Chao Peng <chao.p.peng@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>,
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
        Quentin Perret <qperret@google.com>, tabba@google.com,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        wei.w.wang@intel.com
Subject: [PATCH v10 0/9] KVM: mm: fd-based approach for supporting KVM
Date:   Fri,  2 Dec 2022 14:13:38 +0800
Message-Id: <20221202061347.1070246-1-chao.p.peng@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series implements KVM guest private memory for confidential
computing scenarios like Intel TDX[1]. If a TDX host accesses
TDX-protected guest memory, machine check can happen which can further
crash the running host system, this is terrible for multi-tenant
configurations. The host accesses include those from KVM userspace like
QEMU. This series addresses KVM userspace induced crash by introducing
new mm and KVM interfaces so KVM userspace can still manage guest memory
via a fd-based approach, but it can never access the guest memory
content.

The patch series touches both core mm and KVM code. I appreciate
Andrew/Hugh and Paolo/Sean can review and pick these patches. Any other
reviews are always welcome.
  - 01: mm change, target for mm tree
  - 02-09: KVM change, target for KVM tree

Given KVM is the only current user for the mm part, I have chatted with
Paolo and he is OK to merge the mm change through KVM tree, but
reviewed-by/acked-by is still expected from the mm people.

The patches have been verified with Intel TDX environment, but Vishal
has done an excellent work on the selftests[4] which are dedicated for
this series, making it possible to test this series without innovative
hardware and fancy steps of building a VM environment. See Test section
below for more info.


Introduction
============
KVM userspace being able to crash the host is horrible. Under current
KVM architecture, all guest memory is inherently accessible from KVM
userspace and is exposed to the mentioned crash issue. The goal of this
series is to provide a solution to align mm and KVM, on a userspace
inaccessible approach of exposing guest memory. 

Normally, KVM populates secondary page table (e.g. EPT) by using a host
virtual address (hva) from core mm page table (e.g. x86 userspace page
table). This requires guest memory being mmaped into KVM userspace, but
this is also the source where the mentioned crash issue can happen. In
theory, apart from those 'shared' memory for device emulation etc, guest
memory doesn't have to be mmaped into KVM userspace.

This series introduces fd-based guest memory which will not be mmaped
into KVM userspace. KVM populates secondary page table by using a
fd/offset pair backed by a memory file system. The fd can be created
from a supported memory filesystem like tmpfs/hugetlbfs and KVM can
directly interact with them with newly introduced in-kernel interface,
therefore remove the KVM userspace from the path of accessing/mmaping
the guest memory. 

Kirill had a patch [2] to address the same issue in a different way. It
tracks guest encrypted memory at the 'struct page' level and relies on
HWPOISON to reject the userspace access. The patch has been discussed in
several online and offline threads and resulted in a design document [3]
which is also the original proposal for this series. Later this patch
series evolved as more comments received in community but the major
concepts in [3] still hold true so recommend reading.

The patch series may also be useful for other usages, for example, pure
software approach may use it to harden itself against unintentional
access to guest memory. This series is designed with these usages in
mind but doesn't have code directly support them and extension might be
needed.


mm change
=========
Introduces a new memfd_restricted system call which can create memory
file that is restricted from userspace access via normal MMU operations
like read(), write() or mmap() etc and the only way to use it is
passing it to a third kernel module like KVM and relying on it to
access the fd through the newly added restrictedmem kernel interface.
The restrictedmem interface bridges the memory file subsystems
(tmpfs/hugetlbfs etc) and their users (KVM in this case) and provides
bi-directional communication between them. 


KVM change
==========
Extends the KVM memslot to provide guest private (encrypted) memory from
a fd. With this extension, a single memslot can maintain both private
memory through private fd (restricted_fd/restricted_offset) and shared
(unencrypted) memory through userspace mmaped host virtual address
(userspace_addr). For a particular guest page, the corresponding page in
KVM memslot can be only either private or shared and only one of the
shared/private parts of the memslot is visible to guest. For how this
new extension is used in QEMU, please refer to kvm_set_phys_mem() in
below TDX-enabled QEMU repo.

Introduces new KVM_EXIT_MEMORY_FAULT exit to allow userspace to get the
chance on decision-making for shared <-> private memory conversion. The
exit can be an implicit conversion in KVM page fault handler or an
explicit conversion from guest OS.

Introduces new KVM ioctl KVM_SET_MEMORY_ATTRIBUTES to maintain whether a
page is private or shared. This ioctl allows userspace to convert a page
between private <-> shared. The data maintained tells the truth whether
a guest page is private or shared and this information will be used in
KVM page fault handler to decide whether the private or the shared part
of the memslot is visible to guest.


Test
====
Ran two kinds of tests:
  - Selftests [4] from Vishal and VM boot tests in non-TDX environment
    Code also in below repo: https://github.com/chao-p/linux/tree/privmem-v10

  - Functional tests in TDX capable environment
    Tested the new functionalities in TDX environment. Code repos:
    Linux: https://github.com/chao-p/linux/tree/privmem-v10-tdx
    QEMU: https://github.com/chao-p/qemu/tree/privmem-v10

    An example QEMU command line for TDX test:
    -object tdx-guest,id=tdx,debug=off,sept-ve-disable=off \
    -machine confidential-guest-support=tdx \
    -object memory-backend-memfd-private,id=ram1,size=${mem} \
    -machine memory-backend=ram1


TODO
====
  - Page accounting and limiting for encrypted memory
  - hugetlbfs support


Changelog
=========
v10:
  - mm: hook up restricted_memfd to memory failure and route it to
    kernel users through .error() callback.
  - mm: call invalidate() notifier only for FALLOC_FL_PUNCH_HOLE, i.e.
    not for allocation.
  - KVM: introduce new ioctl KVM_SET_MEMORY_ATTRIBUTES for memory
    conversion instead of reusing KVM_MEMORY_ENCRYPT_{UN,}REG_REGION.
  - KVM: refine gfn-based mmu_notifier_retry() mechanism.
  - KVM: improve lpage_info updating code.
  - KVM: fix the bug in private memory handling that a private fault may
    fall into a non-private memslot.
  - KVM: handle memory machine check error for fd-based memory.
v9:
  - mm: move inaccessible memfd into separated syscall.
  - mm: return page instead of pfn_t for inaccessible_get_pfn and remove
    inaccessible_put_pfn.
  - KVM: rename inaccessible/private to restricted and CONFIG change to
    make the code friendly to pKVM.
  - KVM: add invalidate_begin/end pair to fix race contention and revise
    the lock protection for invalidation path.
  - KVM: optimize setting lpage_info for > 2M level by direct accessing
    lower level's result.
  - KVM: avoid load xarray in kvm_mmu_max_mapping_level() and instead let
    the caller to pass in is_private.
  - KVM: API doc improvement.
v8:
  - mm: redesign mm part by introducing a shim layer(inaccessible_memfd)
    in memfd to avoid touch the memory file systems directly.
  - mm: exclude F_SEAL_AUTO_ALLOCATE as it is for shared memory and
    cause confusion in this series, will send out separately.
  - doc: exclude the man page change, it's not kernel patch and will
    send out separately.
  - KVM: adapt to use the new mm inaccessible_memfd interface.
  - KVM: update lpage_info when setting mem_attr_array to support
    large page.
  - KVM: change from xa_store_range to xa_store for mem_attr_array due
    to xa_store_range overrides all entries which is not intended
    behavior for us.
  - KVM: refine the mmu_invalidate_retry_gfn mechanism for private page.
  - KVM: reorganize KVM_MEMORY_ENCRYPT_{UN,}REG_REGION and private page
    handling code suggested by Sean.
v7:
  - mm: introduce F_SEAL_AUTO_ALLOCATE to avoid double allocation.
  - KVM: use KVM_MEMORY_ENCRYPT_{UN,}REG_REGION to record
    private/shared info.
  - KVM: use similar sync mechanism between zap/page fault paths as
    mmu_notifier for memfile_notifier based invalidation.
v6:
  - mm: introduce MEMFILE_F_* flags into memfile_node to allow checking
    feature consistence among all memfile_notifier users and get rid of
    internal flags like SHM_F_INACCESSIBLE.
  - mm: make pfn_ops callbacks being members of memfile_backing_store
    and then refer to it directly in memfile_notifier.
  - mm: remove backing store unregister.
  - mm: remove RLIMIT_MEMLOCK based memory accounting and limiting.
  - KVM: reorganize patch sequence for page fault handling and private
    memory enabling.
v5:
  - Add man page for MFD_INACCESSIBLE flag and improve KVM API do for
    the new memslot extensions.
  - mm: introduce memfile_{un}register_backing_store to allow memory
    backing store to register/unregister it from memfile_notifier.
  - mm: remove F_SEAL_INACCESSIBLE, use in-kernel flag
    (SHM_F_INACCESSIBLE for shmem) instead. 
  - mm: add memory accounting and limiting (RLIMIT_MEMLOCK based) for
    MFD_INACCESSIBLE memory.
  - KVM: remove the overlap check for mapping the same file+offset into
    multiple gfns due to perf consideration, warned in document.
v4:
  - mm: rename memfd_ops to memfile_notifier and separate it from
    memfd.c to standalone memfile-notifier.c.
  - KVM: move pfn_ops to per-memslot scope from per-vm scope and allow
    registering multiple memslots to the same memory backing store.
  - KVM: add a 'kvm' reference in memslot so that we can recover kvm in
    memfile_notifier handlers.
  - KVM: add 'private_' prefix for the new fields in memslot.
  - KVM: reshape the 'type' to 'flag' for kvm_memory_exit
v3:
  - Remove 'RFC' prefix.
  - Fix race condition between memfile_notifier handlers and kvm destroy.
  - mm: introduce MFD_INACCESSIBLE flag for memfd_create() to force
    setting F_SEAL_INACCESSIBLE when the fd is created.
  - KVM: add the shared part of the memslot back to make private/shared
    pages live in one memslot.

Reference
=========
[1] Intel TDX:
https://www.intel.com/content/www/us/en/developer/articles/technical/intel-trust-domain-extensions.html
[2] Kirill's implementation:
https://lore.kernel.org/all/20210416154106.23721-1-kirill.shutemov@linux.intel.com/T/ 
[3] Original design proposal:
https://lore.kernel.org/all/20210824005248.200037-1-seanjc@google.com/  
[4] Selftest:
https://lore.kernel.org/all/20221111014244.1714148-1-vannapurve@google.com/


Chao Peng (8):
  KVM: Introduce per-page memory attributes
  KVM: Extend the memslot to support fd-based private memory
  KVM: Add KVM_EXIT_MEMORY_FAULT exit
  KVM: Use gfn instead of hva for mmu_notifier_retry
  KVM: Unmap existing mappings when change the memory attributes
  KVM: Update lpage info when private/shared memory are mixed
  KVM: Handle page fault for private memory
  KVM: Enable and expose KVM_MEM_PRIVATE

Kirill A. Shutemov (1):
  mm: Introduce memfd_restricted system call to create restricted user
    memory

 Documentation/virt/kvm/api.rst         | 125 ++++++-
 arch/x86/entry/syscalls/syscall_32.tbl |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 arch/x86/include/asm/kvm_host.h        |   9 +
 arch/x86/kvm/Kconfig                   |   3 +
 arch/x86/kvm/mmu/mmu.c                 | 205 ++++++++++-
 arch/x86/kvm/mmu/mmu_internal.h        |  14 +-
 arch/x86/kvm/mmu/mmutrace.h            |   1 +
 arch/x86/kvm/mmu/tdp_mmu.c             |   2 +-
 arch/x86/kvm/x86.c                     |  17 +-
 include/linux/kvm_host.h               | 103 +++++-
 include/linux/restrictedmem.h          |  71 ++++
 include/linux/syscalls.h               |   1 +
 include/uapi/asm-generic/unistd.h      |   5 +-
 include/uapi/linux/kvm.h               |  53 +++
 include/uapi/linux/magic.h             |   1 +
 kernel/sys_ni.c                        |   3 +
 mm/Kconfig                             |   4 +
 mm/Makefile                            |   1 +
 mm/memory-failure.c                    |   3 +
 mm/restrictedmem.c                     | 318 +++++++++++++++++
 virt/kvm/Kconfig                       |   6 +
 virt/kvm/kvm_main.c                    | 469 +++++++++++++++++++++----
 23 files changed, 1323 insertions(+), 93 deletions(-)
 create mode 100644 include/linux/restrictedmem.h
 create mode 100644 mm/restrictedmem.c


base-commit: df0bb47baa95aad133820b149851d5b94cbc6790
-- 
2.25.1

