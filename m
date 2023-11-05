Return-Path: <linux-fsdevel+bounces-1992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3607E1493
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Nov 2023 17:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C07611C20A11
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Nov 2023 16:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176D53D92;
	Sun,  5 Nov 2023 16:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CLHXlwtK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC6E156F7
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 16:30:58 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87D5DE
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 08:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699201855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QuAi5VixDrrJevZUAF9+CbaiqH+M3FFVThMA5NaO0+Q=;
	b=CLHXlwtKtAb/RDHlpkgOGI8HJN1Z63rWKVYWfyxsPryRoSbPvvxd9jscGF6CQBgt1t5UPo
	oikcYS0kQIiyyt+wcZckLXQf33GtgJqoZNONViyYuTSxvCS+DSBHQasutrIPSr4US3EwGH
	cpfFzsWOQjl2CUpB/Lnkj93NrT4AYqM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-GbgR1JvbNyu7lb61RvuIjQ-1; Sun, 05 Nov 2023 11:30:51 -0500
X-MC-Unique: GbgR1JvbNyu7lb61RvuIjQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D2B9485A58A;
	Sun,  5 Nov 2023 16:30:49 +0000 (UTC)
Received: from avogadro.redhat.com (unknown [10.39.192.93])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 68F572166B26;
	Sun,  5 Nov 2023 16:30:41 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Anup Patel <anup@brainfault.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Sean Christopherson <seanjc@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Chao Peng <chao.p.peng@linux.intel.com>,
	Fuad Tabba <tabba@google.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Anish Moorthy <amoorthy@google.com>,
	David Matlack <dmatlack@google.com>,
	Yu Zhang <yu.c.zhang@linux.intel.com>,
	Isaku Yamahata <isaku.yamahata@intel.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Vlastimil Babka <vbabka@suse.cz>,
	Vishal Annapurve <vannapurve@google.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Maciej Szmigiero <mail@maciej.szmigiero.name>,
	David Hildenbrand <david@redhat.com>,
	Quentin Perret <qperret@google.com>,
	Michael Roth <michael.roth@amd.com>,
	Wang <wei.w.wang@intel.com>,
	Liam Merwick <liam.merwick@oracle.com>,
	Isaku Yamahata <isaku.yamahata@gmail.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v14 00/34] KVM: guest_memfd() and per-page attributes
Date: Sun,  5 Nov 2023 17:30:03 +0100
Message-ID: <20231105163040.14904-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

[If the introduction below is not enough, go read
 https://lwn.net/SubscriberLink/949277/118520c1248ace63/ and subscribe to LWN]

Introduce several new KVM uAPIs to ultimately create a guest-first memory
subsystem within KVM, a.k.a. guest_memfd.  Guest-first memory allows KVM
to provide features, enhancements, and optimizations that are kludgly
or outright impossible to implement in a generic memory subsystem.

The core KVM ioctl() for guest_memfd is KVM_CREATE_GUEST_MEMFD, which
similar to the generic memfd_create(), creates an anonymous file and
returns a file descriptor that refers to it.  Again like "regular"
memfd files, guest_memfd files live in RAM, have volatile storage,
and are automatically released when the last reference is dropped.
The key differences between memfd files (and every other memory subystem)
is that guest_memfd files are bound to their owning virtual machine,
cannot be mapped, read, or written by userspace, and cannot be resized.
guest_memfd files do however support PUNCH_HOLE, which can be used to
convert a guest memory area between the shared and guest-private states.

A second KVM ioctl(), KVM_SET_MEMORY_ATTRIBUTES, allows userspace to
specify attributes for a given page of guest memory.  In the long term,
it will likely be extended to allow userspace to specify per-gfn RWX
protections, including allowing memory to be writable in the guest
without it also being writable in host userspace.

The immediate and driving use case for guest_memfd are Confidential
(CoCo) VMs, specifically AMD's SEV-SNP, Intel's TDX, and KVM's own pKVM.
For such use cases, being able to map memory into KVM guests without
requiring said memory to be mapped into the host is a hard requirement.
While SEV+ and TDX prevent untrusted software from reading guest private
data by encrypting guest memory, pKVM provides confidentiality and
integrity *without* relying on memory encryption.  In addition, with
SEV-SNP and especially TDX, accessing guest private memory can be fatal
to the host, i.e. KVM must be prevent host userspace from accessing
guest memory irrespective of hardware behavior.

Long term, guest_memfd may be useful for use cases beyond CoCo VMs,
for example hardening userspace against unintentional accesses to guest
memory.  As mentioned earlier, KVM's ABI uses userspace VMA protections to
define the allow guest protection (with an exception granted to mapping
guest memory executable), and similarly KVM currently requires the guest
mapping size to be a strict subset of the host userspace mapping size.
Decoupling the mappings sizes would allow userspace to precisely map
only what is needed and with the required permissions, without impacting
guest performance.

A guest-first memory subsystem also provides clearer line of sight to
things like a dedicated memory pool (for slice-of-hardware VMs) and
elimination of "struct page" (for offload setups where userspace _never_
needs to DMA from or into guest memory).

guest_memfd is the result of 3+ years of development and exploration;
taking on memory management responsibilities in KVM was not the first,
second, or even third choice for supporting CoCo VMs.  But after many
failed attempts to avoid KVM-specific backing memory, and looking at
where things ended up, it is quite clear that of all approaches tried,
guest_memfd is the simplest, most robust, and most extensible, and the
right thing to do for KVM and the kernel at-large.

The "development cycle" for this version is going to be very short;
ideally, next week I will merge it as is in kvm/next, taking this through
the KVM tree for 6.8 immediately after the end of the merge window.
The series is still based on 6.6 (plus KVM changes for 6.7) so it
will require a small fixup for changes to get_file_rcu() introduced in
6.7 by commit 0ede61d8589c ("file: convert to SLAB_TYPESAFE_BY_RCU").
The fixup will be done as part of the merge commit, and most of the text
above will become the commit message for the merge.

Because of this, the only two commits that had substantial remarks in v13
(depending on your definition of substantial) are *not* officially part of
this series and will not be merged:

  KVM: Prepare for handling only shared mappings in mmu_notifier events
  KVM: Add transparent hugepage support for dedicated guest memory

Pending post-merge work includes:
- looking into using the restrictedmem framework for guest memory
- introducing a testing mechanism to poison memory, possibly using
  the same memory attributes introduced here
- SNP and TDX support

Non-KVM people, you may want to explicitly ACK two patches buried in the
middle of this series:

  fs: Rename anon_inode_getfile_secure() and anon_inode_getfd_secure()
  mm: Add AS_UNMOVABLE to mark mapping as completely unmovable

The first is small and mostly suggested-by Christian Brauner; the second
a bit less so but it was written by an mm person (Vlastimil Babka).
Note, adding AS_UNMOVABLE isn't strictly required as it's "just" an
optimization, but we'd prefer to have it in place straightaway.

If you would like to see a range-diff, I suggest using Patchew; start
from https://patchew.org/linux/20231027182217.3615211-1-seanjc@google.com/
and click v14 on top.

Thanks,

Paolo

Ackerley Tng (1):
  KVM: selftests: Test KVM exit behavior for private memory/access

Chao Peng (8):
  KVM: Use gfn instead of hva for mmu_notifier_retry
  KVM: Add KVM_EXIT_MEMORY_FAULT exit to report faults to userspace
  KVM: Introduce per-page memory attributes
  KVM: x86: Disallow hugepages when memory attributes are mixed
  KVM: x86/mmu: Handle page fault for private memory
  KVM: selftests: Add KVM_SET_USER_MEMORY_REGION2 helper
  KVM: selftests: Expand set_memory_region_test to validate
    guest_memfd()
  KVM: selftests: Add basic selftest for guest_memfd()

Paolo Bonzini (1):
  fs: Rename anon_inode_getfile_secure() and anon_inode_getfd_secure()

Sean Christopherson (23):
  KVM: Tweak kvm_hva_range and hva_handler_t to allow reusing for gfn
    ranges
  KVM: Assert that mmu_invalidate_in_progress *never* goes negative
  KVM: WARN if there are dangling MMU invalidations at VM destruction
  KVM: PPC: Drop dead code related to KVM_ARCH_WANT_MMU_NOTIFIER
  KVM: PPC: Return '1' unconditionally for KVM_CAP_SYNC_MMU
  KVM: Convert KVM_ARCH_WANT_MMU_NOTIFIER to
    CONFIG_KVM_GENERIC_MMU_NOTIFIER
  KVM: Introduce KVM_SET_USER_MEMORY_REGION2
  KVM: Add a dedicated mmu_notifier flag for reclaiming freed memory
  KVM: Drop .on_unlock() mmu_notifier hook
  mm: Add AS_UNMOVABLE to mark mapping as completely unmovable
  KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing
    memory
  KVM: x86: "Reset" vcpu->run->exit_reason early in KVM_RUN
  KVM: Drop superfluous __KVM_VCPU_MULTIPLE_ADDRESS_SPACE macro
  KVM: Allow arch code to track number of memslot address spaces per VM
  KVM: x86: Add support for "protected VMs" that can utilize private
    memory
  KVM: selftests: Drop unused kvm_userspace_memory_region_find() helper
  KVM: selftests: Convert lib's mem regions to
    KVM_SET_USER_MEMORY_REGION2
  KVM: selftests: Add support for creating private memslots
  KVM: selftests: Introduce VM "shape" to allow tests to specify the VM
    type
  KVM: selftests: Add GUEST_SYNC[1-6] macros for synchronizing more data
  KVM: selftests: Add a memory region subtest to validate invalid flags
  KVM: Prepare for handling only shared mappings in mmu_notifier events
  KVM: Add transparent hugepage support for dedicated guest memory

Vishal Annapurve (3):
  KVM: selftests: Add helpers to convert guest memory b/w private and
    shared
  KVM: selftests: Add helpers to do KVM_HC_MAP_GPA_RANGE hypercalls
    (x86)
  KVM: selftests: Add x86-only selftest for private memory conversions


 Documentation/virt/kvm/api.rst                | 209 +++++++
 arch/arm64/include/asm/kvm_host.h             |   2 -
 arch/arm64/kvm/Kconfig                        |   2 +-
 arch/loongarch/include/asm/kvm_host.h         |   1 -
 arch/loongarch/kvm/Kconfig                    |   2 +-
 arch/mips/include/asm/kvm_host.h              |   2 -
 arch/mips/kvm/Kconfig                         |   2 +-
 arch/powerpc/include/asm/kvm_host.h           |   2 -
 arch/powerpc/kvm/Kconfig                      |   8 +-
 arch/powerpc/kvm/book3s_hv.c                  |   2 +-
 arch/powerpc/kvm/powerpc.c                    |   7 +-
 arch/riscv/include/asm/kvm_host.h             |   2 -
 arch/riscv/kvm/Kconfig                        |   2 +-
 arch/x86/include/asm/kvm_host.h               |  17 +-
 arch/x86/include/uapi/asm/kvm.h               |   3 +
 arch/x86/kvm/Kconfig                          |  14 +-
 arch/x86/kvm/debugfs.c                        |   2 +-
 arch/x86/kvm/mmu/mmu.c                        | 271 +++++++-
 arch/x86/kvm/mmu/mmu_internal.h               |   2 +
 arch/x86/kvm/vmx/vmx.c                        |  11 +-
 arch/x86/kvm/x86.c                            |  26 +-
 fs/anon_inodes.c                              |  47 +-
 fs/userfaultfd.c                              |   5 +-
 include/linux/anon_inodes.h                   |   4 +-
 include/linux/kvm_host.h                      | 144 ++++-
 include/linux/kvm_types.h                     |   1 +
 include/linux/pagemap.h                       |  19 +-
 include/uapi/linux/kvm.h                      |  51 ++
 io_uring/io_uring.c                           |   3 +-
 mm/compaction.c                               |  43 +-
 mm/migrate.c                                  |   2 +
 tools/testing/selftests/kvm/Makefile          |   3 +
 tools/testing/selftests/kvm/dirty_log_test.c  |   2 +-
 .../testing/selftests/kvm/guest_memfd_test.c  | 221 +++++++
 .../selftests/kvm/include/kvm_util_base.h     | 148 ++++-
 .../testing/selftests/kvm/include/test_util.h |   5 +
 .../selftests/kvm/include/ucall_common.h      |  11 +
 .../selftests/kvm/include/x86_64/processor.h  |  15 +
 .../selftests/kvm/kvm_page_table_test.c       |   2 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    | 233 ++++---
 tools/testing/selftests/kvm/lib/memstress.c   |   3 +-
 .../selftests/kvm/set_memory_region_test.c    | 149 +++++
 .../kvm/x86_64/private_mem_conversions_test.c | 487 +++++++++++++++
 .../kvm/x86_64/private_mem_kvm_exits_test.c   | 120 ++++
 .../kvm/x86_64/ucna_injection_test.c          |   2 +-
 virt/kvm/Kconfig                              |  17 +
 virt/kvm/Makefile.kvm                         |   1 +
 virt/kvm/dirty_ring.c                         |   2 +-
 virt/kvm/guest_memfd.c                        | 591 ++++++++++++++++++
 virt/kvm/kvm_main.c                           | 524 +++++++++++++---
 virt/kvm/kvm_mm.h                             |  26 +
 51 files changed, 3174 insertions(+), 296 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/guest_memfd_test.c
 create mode 100644 tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c
 create mode 100644 tools/testing/selftests/kvm/x86_64/private_mem_kvm_exits_test.c
 create mode 100644 virt/kvm/guest_memfd.c

-- 
2.39.1


v13->v14:
============================================================================
KVM: Use gfn instead of hva for mmu_notifier_retry
* add lockdep assertion to kvm_mmu_invalidate_end

KVM: Convert KVM_ARCH_WANT_MMU_NOTIFIER to CONFIG_KVM_GENERIC_MMU_NOTIFIER
* add loongarch hunks

KVM: Introduce KVM_SET_USER_MEMORY_REGION2
* renumber capability
* define and test KVM_SET_USER_MEMORY_REGION_V1_FLAGS

KVM: Add KVM_EXIT_MEMORY_FAULT exit to report faults to userspace
* adjust field name in documentation from "memory" to "memory_fault"
* renumber exit and capability

KVM: Drop .on_unlock() mmu_notifier hook
* lockdep assertion to kvm_mmu_invalidate_end moved earlier

KVM: Introduce per-page memory attributes
* remove mentions of KVM_GET_SUPPORTED_MEMORY_ATTRIBUTES
* remove mentions of only_private/only_shared
* document locking policy for mem_attr_array
* renumber capability
* fix typos
* fix implementation of KVM_CHECK_EXTENSION for new capability

fs: Rename anon_inode_getfile_secure() and anon_inode_getfd_secure()
* new patch.

KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory
* rename KVM_MEM_PRIVATE to KVM_MEM_GUEST_MEMFD
* fix space/TAB mishap in documentation
* fix typos
* include EXPORT_SYMBOL_GPL for anon_inode_create_getfile
* renumber capability
* remove unnecessary TODO comments
* fix size check to "<= 0"
* fix missing fput() in kvm_gmem_bind()
* fix to KVM_CHECK_EXTENSION(KVM_CAP_MEMORY_ATTRIBUTES) moved earlier

KVM: x86: Add support for "protected VMs" that can utilize private memory
* renumber capabilities

KVM: selftests: Add support for creating private memslots
KVM: selftests: Add helpers to convert guest memory b/w private and shared
KVM: selftests: Add x86-only selftest for private memory conversions
KVM: selftests: Expand set_memory_region_test to validate guest_memfd()
KVM: selftests: Add basic selftest for guest_memfd()
KVM: selftests: Test KVM exit behavior for private memory/access
* rename KVM_MEM_PRIVATE to KVM_MEM_GUEST_MEMFD
* remove KVM_GUEST_MEMFD_ALLOW_HUGEPAGE

KVM: Prepare for handling only shared mappings in mmu_notifier events
* reword comment
* move only_private/only_shared hunk from earlier

KVM: Add transparent hugepage support for dedicated guest memory
* add back all KVM_GUEST_MEMFD_ALLOW_HUGEPAGE uses from tests
* do not require CONFIG_TRANSPARENT_HUGEPAGE
* more precise use of pgoff_t
* pass order down to kvm_gmem_get_huge_folio
============================================================================






