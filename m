Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4DD758925
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 01:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjGRXsf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 19:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjGRXse (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 19:48:34 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A1EF7
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jul 2023 16:48:32 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1b8a7735231so33085335ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jul 2023 16:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689724111; x=1692316111;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNioK2g9uNSVoz4fz3Z0hsZYDZVWPADHE8SV+5umY4Y=;
        b=osgDTqFdq8IUMbfc5np0SJw5OdVmryzKJlMbpWPj1r+bA24M0IJWiJbXigx+jJyQ5r
         VlxW0vuMxM/BQlBSs2+AumxHcyWajcOP9JXOkoHqOoO5ZyUcko/ezFKjsqiJkNtv/xwh
         Y36DMIRI0Q59f7++kPXdwd59QUGKV3Guy/2lgpB3TxpICSaTd3h59fkFiz7MblIecyH8
         n7z4KTAocelQbqspLYM5QVY6G/2MvezetA6jqdURrMQiYzDhQ6XI2ghHbJziqFDRtHCX
         N3lBCweEXoqVHi335cB6PiCMKD3JW4ZiPc0eG4mYnlS454U3dCWqPiIky3zkEczL9g5Z
         g/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689724111; x=1692316111;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kNioK2g9uNSVoz4fz3Z0hsZYDZVWPADHE8SV+5umY4Y=;
        b=TmvaBTWSXmg9FoWqNOFllgvSiSv52KnwS2m7yDg1CZlqk5I5m9ffX+IRiFa2Bvns7U
         +g7Ed+LwPv93IW51iTFwoSEkbjuUHkmhivgpllWJFHVnlfM9UuOYemUNlx/AZ1TyD/aA
         mcM5QaKzHzhHA5LeiB0Oh0XrXvMm8CpSXLzfnXzfPalg8t8XtyvJlNdBHmyj0GSTPLjR
         8d/T2zO7/aqzWo+nMwtEA6qhDBVBMQHaotlv0zTmzqMgLbQ24bZOrEZB59tpKBgmB+KH
         OcO0AnkFK1Ioyo6qwYK8sARokE0WiF/NJqo04owlotMRSbt1CyWp0tP86La4UGb9uLdt
         8tkQ==
X-Gm-Message-State: ABy/qLZbTIyiZVYDvGzrZ7qI+VbaQQQg1m3Ltsouantb07SPRZcOLsJX
        vO9bv7RqXieTOzDRiEEMMW1d683V2zs=
X-Google-Smtp-Source: APBJJlGfvW12PoU1cgYxoig33TTppXu/jdZjVA/UYCNl9+6h2sdMFpEn0Y/2jF1wf15jCGzWeLtg2m+RbUw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ec8c:b0:1b8:95fc:d0f with SMTP id
 x12-20020a170902ec8c00b001b895fc0d0fmr7816plg.7.1689724111171; Tue, 18 Jul
 2023 16:48:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 18 Jul 2023 16:44:43 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230718234512.1690985-1-seanjc@google.com>
Subject: [RFC PATCH v11 00/29]  KVM: guest_memfd() and per-page attributes
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
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the next iteration of implementing fd-based (instead of vma-based)
memory for KVM guests.  If you want the full background of why we are doing
this, please go read the v10 cover letter[1].

The biggest change from v10 is to implement the backing storage in KVM
itself, and expose it via a KVM ioctl() instead of a "generic" sycall.
See link[2] for details on why we pivoted to a KVM-specific approach.

Key word is "biggest".  Relative to v10, there are many big changes.
Highlights below (I can't remember everything that got changed at
this point).

Tagged RFC as there are a lot of empty changelogs, and a lot of missing
documentation.  And ideally, we'll have even more tests before merging.
There are also several gaps/opens (to be discussed in tomorrow's PUCK).

v11:
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

[1] https://lore.kernel.org/all/20221202061347.1070246-1-chao.p.peng@linux.intel.com
[2] https://lore.kernel.org/all/ZEM5Zq8oo+xnApW9@google.com

Ackerley Tng (1):
  KVM: selftests: Test KVM exit behavior for private memory/access

Chao Peng (7):
  KVM: Use gfn instead of hva for mmu_notifier_retry
  KVM: Add KVM_EXIT_MEMORY_FAULT exit
  KVM: Introduce per-page memory attributes
  KVM: x86: Disallow hugepages when memory attributes are mixed
  KVM: x86/mmu: Handle page fault for private memory
  KVM: selftests: Add KVM_SET_USER_MEMORY_REGION2 helper
  KVM: selftests: Expand set_memory_region_test to validate
    guest_memfd()

Sean Christopherson (18):
  KVM: Wrap kvm_gfn_range.pte in a per-action union
  KVM: Tweak kvm_hva_range and hva_handler_t to allow reusing for gfn
    ranges
  KVM: PPC: Drop dead code related to KVM_ARCH_WANT_MMU_NOTIFIER
  KVM: Convert KVM_ARCH_WANT_MMU_NOTIFIER to
    CONFIG_KVM_GENERIC_MMU_NOTIFIER
  KVM: Introduce KVM_SET_USER_MEMORY_REGION2
  mm: Add AS_UNMOVABLE to mark mapping as completely unmovable
  security: Export security_inode_init_security_anon() for use by KVM
  KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing
    memory
  KVM: Add transparent hugepage support for dedicated guest memory
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
  KVM: selftests: Add basic selftest for guest_memfd()

Vishal Annapurve (3):
  KVM: selftests: Add helpers to convert guest memory b/w private and
    shared
  KVM: selftests: Add helpers to do KVM_HC_MAP_GPA_RANGE hypercalls
    (x86)
  KVM: selftests: Add x86-only selftest for private memory conversions

 Documentation/virt/kvm/api.rst                | 114 ++++
 arch/arm64/include/asm/kvm_host.h             |   2 -
 arch/arm64/kvm/Kconfig                        |   2 +-
 arch/arm64/kvm/mmu.c                          |   2 +-
 arch/mips/include/asm/kvm_host.h              |   2 -
 arch/mips/kvm/Kconfig                         |   2 +-
 arch/mips/kvm/mmu.c                           |   2 +-
 arch/powerpc/include/asm/kvm_host.h           |   2 -
 arch/powerpc/kvm/Kconfig                      |   8 +-
 arch/powerpc/kvm/book3s_hv.c                  |   2 +-
 arch/powerpc/kvm/powerpc.c                    |   5 +-
 arch/riscv/include/asm/kvm_host.h             |   2 -
 arch/riscv/kvm/Kconfig                        |   2 +-
 arch/riscv/kvm/mmu.c                          |   2 +-
 arch/x86/include/asm/kvm_host.h               |  17 +-
 arch/x86/include/uapi/asm/kvm.h               |   3 +
 arch/x86/kvm/Kconfig                          |  14 +-
 arch/x86/kvm/debugfs.c                        |   2 +-
 arch/x86/kvm/mmu/mmu.c                        | 287 +++++++-
 arch/x86/kvm/mmu/mmu_internal.h               |   4 +
 arch/x86/kvm/mmu/mmutrace.h                   |   1 +
 arch/x86/kvm/mmu/tdp_mmu.c                    |   8 +-
 arch/x86/kvm/vmx/vmx.c                        |  11 +-
 arch/x86/kvm/x86.c                            |  24 +-
 include/linux/kvm_host.h                      | 129 +++-
 include/linux/pagemap.h                       |  11 +
 include/uapi/linux/kvm.h                      |  50 ++
 include/uapi/linux/magic.h                    |   1 +
 mm/compaction.c                               |   4 +
 mm/migrate.c                                  |   2 +
 security/security.c                           |   1 +
 tools/testing/selftests/kvm/Makefile          |   3 +
 tools/testing/selftests/kvm/dirty_log_test.c  |   2 +-
 .../testing/selftests/kvm/guest_memfd_test.c  | 114 ++++
 .../selftests/kvm/include/kvm_util_base.h     | 141 +++-
 .../testing/selftests/kvm/include/test_util.h |   5 +
 .../selftests/kvm/include/ucall_common.h      |  12 +
 .../selftests/kvm/include/x86_64/processor.h  |  15 +
 .../selftests/kvm/kvm_page_table_test.c       |   2 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    | 230 ++++---
 tools/testing/selftests/kvm/lib/memstress.c   |   3 +-
 .../selftests/kvm/set_memory_region_test.c    |  99 +++
 .../kvm/x86_64/private_mem_conversions_test.c | 408 +++++++++++
 .../kvm/x86_64/private_mem_kvm_exits_test.c   | 115 ++++
 .../kvm/x86_64/ucna_injection_test.c          |   2 +-
 virt/kvm/Kconfig                              |  17 +
 virt/kvm/Makefile.kvm                         |   1 +
 virt/kvm/dirty_ring.c                         |   2 +-
 virt/kvm/guest_mem.c                          | 635 ++++++++++++++++++
 virt/kvm/kvm_main.c                           | 384 +++++++++--
 virt/kvm/kvm_mm.h                             |  38 ++
 51 files changed, 2700 insertions(+), 246 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/guest_memfd_test.c
 create mode 100644 tools/testing/selftests/kvm/x86_64/private_mem_conversions_test.c
 create mode 100644 tools/testing/selftests/kvm/x86_64/private_mem_kvm_exits_test.c
 create mode 100644 virt/kvm/guest_mem.c


base-commit: fdf0eaf11452d72945af31804e2a1048ee1b574c
-- 
2.41.0.255.g8b1d071c50-goog

