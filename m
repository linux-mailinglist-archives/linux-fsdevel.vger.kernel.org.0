Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D1179F6B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 03:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbjINB4N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 21:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233609AbjINBzq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 21:55:46 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2DA1FEA
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 18:55:36 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1c08a15fcf4so3862525ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 18:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694656535; x=1695261335; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJKy84XSuMTmOC63vQkGfkXTGkwOOuRa5fNJs1nSv9Y=;
        b=OmuuHmVp88oV0ZN3hZneCd3NQcP8EpH+nCF9AJeg07IQEEJGUgx+JQcAqnKVzOhs/N
         wD/5hTrs4+3L1wdSxsivTdczQ9+GFlaeSzD0r9Nyz8I/MoFmP98hkTY1NEz6yGDILjyT
         WY9l+VT3Muh5SS43js3l9zMDeJN8Vfsxe1jpPnmcvCYpxfUVNLUMF9b15oNtLmtGHZBF
         JTD887sOuuGmszapf8eR1Qdc/KM9HW/JEntrvs7aSsIxYqnEeu2WaJX8JZw4Chz3XshG
         o9N1oUr70zvmwoj1FNfBubKfB5GVLoL/MXjFlD11N0/AEwyWRkbhVGJvtX/arbuehnI5
         H6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694656535; x=1695261335;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bJKy84XSuMTmOC63vQkGfkXTGkwOOuRa5fNJs1nSv9Y=;
        b=BmRhHHuLhE4lpbwXEo7JHxpd2zqfo535h6kscke0/QC+3xDaRtmd0fV3AE8blB4JrY
         TLTtUWMGp2pbzYiX0R4rhuiiEnc2kM66FjYvksd22/+joowTZvnmRoLftD5dNcYKT2KB
         dRR7KMrcIKSSSt+nPyDYXk4+TEaI89uzHuKVLsih3Fjf46HsajTbEelD5baMy35MT6xY
         +VnG53frm2AY6mlLf1o/bAI64ksMzzq4Se/bIqEv8qUIBSL2IDHJLywgA16Ub44aAeTy
         pGjNR2+1WXc+i5bdn4Yw2lD+u27ArjitoE76UdcnVkLVplKCvkK6+vGSztFNP95fx3MG
         pE8g==
X-Gm-Message-State: AOJu0Yzw0kyuUB3dv9YJldueoPSVdw3I//85qGgMbGYeSJ/xtdGkX+//
        2lKUfy312mAvuQa2BlDG4kigXiU7Bj0=
X-Google-Smtp-Source: AGHT+IGnw6PJDWM0E1VK/7ZuUO30qpP9NQbgvDz7dNd87qt+PDes/hO2OajwY8ZpLg9diAiXM3Vfd4Drz0o=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:2445:b0:1c3:1ceb:97b6 with SMTP id
 l5-20020a170903244500b001c31ceb97b6mr183120pls.7.1694656535510; Wed, 13 Sep
 2023 18:55:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 13 Sep 2023 18:54:58 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230914015531.1419405-1-seanjc@google.com>
Subject: [RFC PATCH v12 00/33] KVM: guest_memfd() and per-page attributes
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sean Christopherson <seanjc@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Fuad Tabba <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Anish Moorthy <amoorthy@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Xu Yilun <yilun.xu@intel.com>,
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is hopefully the last RFC for implementing fd-based (instead of vma-based)
memory for KVM guests.  If you want the full background of why we are doing
this, please go read the v10 cover letter.  With luck, v13 will be a "normal"
series that's ready for inclusion.

Tagged RFC as there are still several empty changelogs, a lot of missing
documentation, and a handful of TODOs.  And I haven't tested or proofread this
anywhere near as much as I normally would.  I am posting even though the
remaining TODOs aren't _that_ big so that people can test this new version
without having to wait a few weeks to close out the remaining TODOs, i.e. to
give us at least some chance of hitting v6.7.

The most relevant TODO item for non-KVM folks is that we are planning on
dropping the dedicated "gmem" file system.  Assuming that pans out, the patch
to export security_inode_init_security_anon() should go away.

KVM folks, there a few changes I want to highlight and get feedback on, all of
which are directly related to the "annotated memory faults" series[*]:

 - Rename kvm_run.memory to kvm_run.memory_fault
 - Place "memory_fault" in a separate union
 - Return -EFAULT or -EHWPOISON with exiting with KVM_EXIT_MEMORY_FAULT

The first one is pretty self-explanatory, "run->memory.gpa" looks quite odd and
would prevent ever doing something directly with memory.

Putting the struct in a separate union is not at all necessary for supporting
private memory, it's purely forward looking to Anish series, which wants to
annotate (fill memory_fault) on all faults, even if KVM ultimately doesn't exit
to userspace (x86 has a few unfortunate flows where KVM can clobber a previous
exit, or suppress a memory fault exit).  Using a separate union, i.e. different
bytes in kvm_run, allows exiting to userspace with both memory_fault and the
"normal" union filled, e.g. if KVM starts an MMIO exit and then hits a memory
fault exit, the MMIO exit will be preserved.  It's unlikely userspace will be
able to do anything useful with the info in that case, but the reverse will
likely be much more interesting, e.g. if KVM hits a memory fault and then doesn't
report it to userspace for whatever reason.

As for returning -EFAULT/-EHWPOISON, far too many helpers that touch guest
memory, i.e. can "fault", return 0 on success, which makes it all bug impossible
to use '0' to signal "exit to userspace".  Rather than use '0' for _just_ the
case where the guest is accessing private vs. shared, my thought is to use
-EFAULT everywhere except for the poisoned page case.

[*] https://lore.kernel.org/all/20230908222905.1321305-1-amoorthy@google.com

TODOs [owner]:
 - Documentation [none]
 - Changelogs [Sean]
 - Fully anonymous inode vs. proper filesystem [Paolo]
 - kvm_gmem_error_page() testing (my version is untested) [Isaku?]

v12:
 - Squash fixes from others. [Many people]
 - Kill of the .on_unlock() callback and use .on_lock() when handling
   memory attributes updates. [Isaku]
 - Add more tests. [Ackerley]
 - Move range_has_attrs() to common code. [Paolo]
 - Return actually number of address spaces for the VM-scoped version of
   KVM_CAP_MULTI_ADDRESS_SPACE. [Paolo]
 - Move forward declaration of "struct kvm_gfn_range" to kvm_types.h. [Yuan]
 - Plumb code to have HVA-based mmu_notifier events affect only shared
   mappings. [Asish]
 - Clean up kvm_vm_ioctl_set_mem_attributes() math. [Binbin]
 - Collect a few reviews and acks. [Paolo, Paul]
 - Unconditionally advertise a synchronized MMU on PPC. [Paolo]
 - Check for error return from filemap_grab_folio(). [A
 - Make max_order optional. [Fuad]
 - Remove signal injection, zap SPTEs on memory error. [Isaku]
 - Add KVM_CAP_GUEST_MEMFD. [Xiaoyao]
 - Invoke kvm_arch_pre_set_memory_attributes() instead of
   kvm_mmu_unmap_gfn_range().
 - Rename kvm_run.memory to kvm_run.memory_fault
 - Place "memory_fault" in a separate union
 - Return -EFAULT and -EHWPOISON with KVM_EXIT_MEMORY_FAULT
 - "Init" run->exit_reason in x86's vcpu_run()

v11:
 - https://lore.kernel.org/all/20230718234512.1690985-1-seanjc@google.com
 - Test private<=>shared conversions *without* doing fallocate()
 - PUNCH_HOLE all memory between iterations of the conversion test so that
   KVM doesn't retain pages in the guest_memfd
 - Rename hugepage control to be a very generic ALLOW_HUGEPAGE, instead of
   giving it a THP or PMD specific name.
 - Fold in fixes from a lot of people (thank you!)
 - Zap SPTEs *before* updating attributes to ensure no weirdness, e.g. if
   KVM handles a page fault and looks at inconsistent attributes
 - Refactor MMU interaction with attributes updates to reuse much of KVM's
   framework for mmu_notifiers.

v10: https://lore.kernel.org/all/20221202061347.1070246-1-chao.p.peng@linux.intel.com

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

Sean Christopherson (21):
  KVM: Tweak kvm_hva_range and hva_handler_t to allow reusing for gfn
    ranges
  KVM: PPC: Drop dead code related to KVM_ARCH_WANT_MMU_NOTIFIER
  KVM: PPC: Return '1' unconditionally for KVM_CAP_SYNC_MMU
  KVM: Convert KVM_ARCH_WANT_MMU_NOTIFIER to
    CONFIG_KVM_GENERIC_MMU_NOTIFIER
  KVM: Introduce KVM_SET_USER_MEMORY_REGION2
  KVM: Add a dedicated mmu_notifier flag for reclaiming freed memory
  KVM: Drop .on_unlock() mmu_notifier hook
  KVM: Set the stage for handling only shared mappings in mmu_notifier
    events
  mm: Add AS_UNMOVABLE to mark mapping as completely unmovable
  security: Export security_inode_init_security_anon() for use by KVM
  KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing
    memory
  KVM: Add transparent hugepage support for dedicated guest memory
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

Vishal Annapurve (3):
  KVM: selftests: Add helpers to convert guest memory b/w private and
    shared
  KVM: selftests: Add helpers to do KVM_HC_MAP_GPA_RANGE hypercalls
    (x86)
  KVM: selftests: Add x86-only selftest for private memory conversions

 Documentation/virt/kvm/api.rst                | 116 ++++
 arch/arm64/include/asm/kvm_host.h             |   2 -
 arch/arm64/kvm/Kconfig                        |   2 +-
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
 arch/x86/kvm/mmu/mmu.c                        | 264 +++++++-
 arch/x86/kvm/mmu/mmu_internal.h               |   2 +
 arch/x86/kvm/mmu/tdp_mmu.c                    |   2 +-
 arch/x86/kvm/vmx/vmx.c                        |  11 +-
 arch/x86/kvm/x86.c                            |  25 +-
 include/linux/kvm_host.h                      | 143 +++-
 include/linux/kvm_types.h                     |   1 +
 include/linux/pagemap.h                       |  19 +-
 include/uapi/linux/kvm.h                      |  67 ++
 include/uapi/linux/magic.h                    |   1 +
 mm/compaction.c                               |  43 +-
 mm/migrate.c                                  |   2 +
 security/security.c                           |   1 +
 tools/testing/selftests/kvm/Makefile          |   3 +
 tools/testing/selftests/kvm/dirty_log_test.c  |   2 +-
 .../testing/selftests/kvm/guest_memfd_test.c  | 165 +++++
 .../selftests/kvm/include/kvm_util_base.h     | 148 +++-
 .../testing/selftests/kvm/include/test_util.h |   5 +
 .../selftests/kvm/include/ucall_common.h      |  11 +
 .../selftests/kvm/include/x86_64/processor.h  |  15 +
 .../selftests/kvm/kvm_page_table_test.c       |   2 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    | 231 ++++---
 tools/testing/selftests/kvm/lib/memstress.c   |   3 +-
 .../selftests/kvm/set_memory_region_test.c    | 100 +++
 .../kvm/x86_64/private_mem_conversions_test.c | 410 +++++++++++
 .../kvm/x86_64/private_mem_kvm_exits_test.c   | 121 ++++
 .../kvm/x86_64/ucna_injection_test.c          |   2 +-
 virt/kvm/Kconfig                              |  17 +
 virt/kvm/Makefile.kvm                         |   1 +
 virt/kvm/dirty_ring.c                         |   2 +-
 virt/kvm/guest_mem.c                          | 637 ++++++++++++++++++
 virt/kvm/kvm_main.c                           | 482 +++++++++++--
 virt/kvm/kvm_mm.h                             |  38 ++
 48 files changed, 2888 insertions(+), 271 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/guest_memfd_test.c
 create mode 100644 tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c
 create mode 100644 tools/testing/selftests/kvm/x86_64/private_mem_kvm_exits_test.c
 create mode 100644 virt/kvm/guest_mem.c


base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
-- 
2.42.0.283.g2d96d420d3-goog

