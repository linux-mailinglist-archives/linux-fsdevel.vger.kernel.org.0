Return-Path: <linux-fsdevel+bounces-3692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EC07F791D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 17:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D24BC1C20935
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 16:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37D4341A6;
	Fri, 24 Nov 2023 16:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FC8B19A6;
	Fri, 24 Nov 2023 08:35:23 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37043FEC;
	Fri, 24 Nov 2023 08:36:09 -0800 (PST)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 856613F73F;
	Fri, 24 Nov 2023 08:35:20 -0800 (PST)
From: Joey Gouly <joey.gouly@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: akpm@linux-foundation.org,
	aneesh.kumar@linux.ibm.com,
	broonie@kernel.org,
	catalin.marinas@arm.com,
	dave.hansen@linux.intel.com,
	joey.gouly@arm.com,
	maz@kernel.org,
	oliver.upton@linux.dev,
	shuah@kernel.org,
	will@kernel.org,
	kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v3 00/25] Permission Overlay Extension
Date: Fri, 24 Nov 2023 16:34:45 +0000
Message-Id: <20231124163510.1835740-1-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello everyone,

This series implements the Permission Overlay Extension introduced in 2022
VMSA enhancements [1]. It is based on v6.7-rc2.

Changes since v2[2]:
	# Added ptrace support and selftest
	# Add missing POR_EL0 initialisation in fork/clone
	# Rebase onto v6.7-rc2
	# Add r-bs

The Permission Overlay Extension allows to constrain permissions on memory
regions. This can be used from userspace (EL0) without a system call or TLB
invalidation.

POE is used to implement the Memory Protection Keys [3] Linux syscall.

The first few patches add the basic framework, then the PKEYS interface is
implemented, and then the selftests are made to work on arm64.

There was discussion about what the 'default' protection key value should be,
I used disallow-all (apart from pkey 0), which matches what x86 does.

I have tested the modified protection_keys test on x86_64, but not PPC.
I haven't build tested the x86/ppc arch changes.

Thanks,
Joey

[1] https://community.arm.com/arm-community-blogs/b/architectures-and-processors-blog/posts/arm-a-profile-architecture-2022
[2] https://lore.kernel.org/linux-arm-kernel/20231027180850.1068089-1-joey.gouly@arm.com/
[3] Documentation/core-api/protection-keys.rst

Joey Gouly (25):
  arm64/sysreg: add system register POR_EL{0,1}
  arm64/sysreg: update CPACR_EL1 register
  arm64: cpufeature: add Permission Overlay Extension cpucap
  arm64: disable trapping of POR_EL0 to EL2
  arm64: context switch POR_EL0 register
  KVM: arm64: Save/restore POE registers
  arm64: enable the Permission Overlay Extension for EL0
  arm64: add POIndex defines
  arm64: define VM_PKEY_BIT* for arm64
  arm64: mask out POIndex when modifying a PTE
  arm64: enable ARCH_HAS_PKEYS on arm64
  arm64: handle PKEY/POE faults
  arm64: stop using generic mm_hooks.h
  arm64: implement PKEYS support
  arm64: add POE signal support
  arm64: enable PKEY support for CPUs with S1POE
  arm64: enable POE and PIE to coexist
  arm64/ptrace: add support for FEAT_POE
  kselftest/arm64: move get_header()
  selftests: mm: move fpregs printing
  selftests: mm: make protection_keys test work on arm64
  kselftest/arm64: add HWCAP test for FEAT_S1POE
  kselftest/arm64: parse POE_MAGIC in a signal frame
  kselftest/arm64: Add test case for POR_EL0 signal frame records
  KVM: selftests: get-reg-list: add Permission Overlay registers

 Documentation/arch/arm64/elf_hwcaps.rst       |   3 +
 arch/arm64/Kconfig                            |  18 +++
 arch/arm64/include/asm/cpufeature.h           |   6 +
 arch/arm64/include/asm/el2_setup.h            |  10 +-
 arch/arm64/include/asm/hwcap.h                |   1 +
 arch/arm64/include/asm/kvm_arm.h              |   4 +-
 arch/arm64/include/asm/kvm_host.h             |   4 +
 arch/arm64/include/asm/mman.h                 |   8 +-
 arch/arm64/include/asm/mmu.h                  |   2 +
 arch/arm64/include/asm/mmu_context.h          |  51 ++++++-
 arch/arm64/include/asm/page.h                 |  10 ++
 arch/arm64/include/asm/pgtable-hwdef.h        |  10 ++
 arch/arm64/include/asm/pgtable-prot.h         |   8 +-
 arch/arm64/include/asm/pgtable.h              |  26 +++-
 arch/arm64/include/asm/pkeys.h                | 110 ++++++++++++++
 arch/arm64/include/asm/por.h                  |  33 +++++
 arch/arm64/include/asm/processor.h            |   1 +
 arch/arm64/include/asm/sysreg.h               |  16 ++
 arch/arm64/include/asm/traps.h                |   1 +
 arch/arm64/include/uapi/asm/hwcap.h           |   1 +
 arch/arm64/include/uapi/asm/sigcontext.h      |   7 +
 arch/arm64/kernel/cpufeature.c                |  23 +++
 arch/arm64/kernel/cpuinfo.c                   |   1 +
 arch/arm64/kernel/process.c                   |  22 +++
 arch/arm64/kernel/ptrace.c                    |  46 ++++++
 arch/arm64/kernel/signal.c                    |  51 +++++++
 arch/arm64/kernel/traps.c                     |  12 +-
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h    |  10 ++
 arch/arm64/kvm/sys_regs.c                     |   2 +
 arch/arm64/mm/fault.c                         |  44 +++++-
 arch/arm64/mm/mmap.c                          |   9 ++
 arch/arm64/mm/mmu.c                           |  40 +++++
 arch/arm64/tools/cpucaps                      |   1 +
 arch/arm64/tools/sysreg                       |  15 +-
 arch/powerpc/include/asm/page.h               |  11 ++
 arch/x86/include/asm/page.h                   |  10 ++
 fs/proc/task_mmu.c                            |   2 +
 include/linux/mm.h                            |  13 --
 include/uapi/linux/elf.h                      |   1 +
 tools/testing/selftests/arm64/abi/hwcap.c     |  14 ++
 .../testing/selftests/arm64/signal/.gitignore |   1 +
 .../arm64/signal/testcases/poe_siginfo.c      |  86 +++++++++++
 .../arm64/signal/testcases/testcases.c        |  27 +---
 .../arm64/signal/testcases/testcases.h        |  28 +++-
 .../selftests/kvm/aarch64/get-reg-list.c      |  14 ++
 tools/testing/selftests/mm/Makefile           |   2 +-
 tools/testing/selftests/mm/pkey-arm64.h       | 139 ++++++++++++++++++
 tools/testing/selftests/mm/pkey-helpers.h     |   8 +
 tools/testing/selftests/mm/pkey-powerpc.h     |   3 +
 tools/testing/selftests/mm/pkey-x86.h         |   4 +
 tools/testing/selftests/mm/protection_keys.c  | 109 ++++++++++++--
 51 files changed, 1011 insertions(+), 67 deletions(-)
 create mode 100644 arch/arm64/include/asm/pkeys.h
 create mode 100644 arch/arm64/include/asm/por.h
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/poe_siginfo.c
 create mode 100644 tools/testing/selftests/mm/pkey-arm64.h

-- 
2.25.1


