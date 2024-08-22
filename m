Return-Path: <linux-fsdevel+bounces-26750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4C795B965
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5219A2855BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BB51CC880;
	Thu, 22 Aug 2024 15:11:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DE61CBE89;
	Thu, 22 Aug 2024 15:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724339486; cv=none; b=nwu33zBtUNahIw0FJrnVJtRySBcAk8CCx843rq72xO9ubpoOG1Z64flYQYoVRMBnIZ6wj2jXffHM46nbMrSFs8zT6ItZe5o5KeN9DPdGCdia81IjDtpQ/nImsDnBOVIBLDvzPsDriFlHTSFGtyx7oD+XLx12VRlPwN5VnSA7pxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724339486; c=relaxed/simple;
	bh=/FMZHU5iQ5bZSW66TvGt+m6RFBSaOJTfr8aPbHQt0lA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YgXKq71Li9glm0y3npjOaEo8VpNWXMC+VjcN5guN//2l94T8V0oxgjb99ZRevoARFmdaeiHy2f8u5ZQCbPTdkdTTxGH5yqSwDTRCtx8gklsB3wIWhP68/ltGxW2A+Czvn79AUC7G4efW0VmEVSI96arPjaGxy1icMgbP/8Pli2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B47FDA7;
	Thu, 22 Aug 2024 08:11:50 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A0263F58B;
	Thu, 22 Aug 2024 08:11:20 -0700 (PDT)
From: Joey Gouly <joey.gouly@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: nd@arm.com,
	akpm@linux-foundation.org,
	aneesh.kumar@kernel.org,
	aneesh.kumar@linux.ibm.com,
	anshuman.khandual@arm.com,
	bp@alien8.de,
	broonie@kernel.org,
	catalin.marinas@arm.com,
	christophe.leroy@csgroup.eu,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	joey.gouly@arm.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	maz@kernel.org,
	mingo@redhat.com,
	mpe@ellerman.id.au,
	naveen.n.rao@linux.ibm.com,
	npiggin@gmail.com,
	oliver.upton@linux.dev,
	shuah@kernel.org,
	skhan@linuxfoundation.org,
	szabolcs.nagy@arm.com,
	tglx@linutronix.de,
	will@kernel.org,
	x86@kernel.org,
	kvmarm@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v5 00/30] Permission Overlay Extension
Date: Thu, 22 Aug 2024 16:10:43 +0100
Message-Id: <20240822151113.1479789-1-joey.gouly@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This series implements the Permission Overlay Extension introduced in 2022
VMSA enhancements [1]. It is based on v6.11-rc4.

Changes since v4[2]:
	- Added Acks and R-bs, thanks!
	- KVM:
		- Move POR_EL{0,1} handling inside TCR_EL2 blocks
		- Add visibility functions for registers [4]
		- Make ID_AA64MMFR3_EL1 writable
	- use system_supports_poe() more consistently
	- use BIT instead of hex constants
	- fix off-by-one in arch_max_pkey() macro
	- add PKEY_DISABLE_EXECUTE and PKEY_DISABLE_READ
	- Update some comments and commit messages.
	- No change to when we save/restore POR_EL0 for signals!

Conflicts with GCS:
	- Uses the same (last) bit in HWCAP2
	- Uses the same VM_HIGH_ARCH_5

Conflicts with arm64 KVM:
	- Maz has taken patch 8 into one of his own series
	- I have taken and modified a patch from Maz (patch 9)

The Permission Overlay Extension allows to constrain permissions on memory
regions. This can be used from userspace (EL0) without a system call or TLB
invalidation.

POE is used to implement the Memory Protection Keys [3] Linux syscall.

The first few patches add the basic framework, then the PKEYS interface is
implemented, and then the selftests are made to work on arm64.

I have tested the modified protection_keys test on x86_64, but not PPC.
I haven't build tested the x86/ppc arch changes.

Thanks,
Joey

[1] https://community.arm.com/arm-community-blogs/b/architectures-and-processors-blog/posts/arm-a-profile-architecture-2022
[2] https://lore.kernel.org/linux-arm-kernel/20240503130147.1154804-1-joey.gouly@arm.com/
[3] Documentation/core-api/protection-keys.rst
[4] https://lore.kernel.org/linux-arm-kernel/20240806-kvm-arm64-get-reg-list-v2-0-1d3fbc7b6844@kernel.org/

Joey Gouly (30):
  powerpc/mm: add ARCH_PKEY_BITS to Kconfig
  x86/mm: add ARCH_PKEY_BITS to Kconfig
  mm: use ARCH_PKEY_BITS to define VM_PKEY_BITN
  arm64: disable trapping of POR_EL0 to EL2
  arm64: cpufeature: add Permission Overlay Extension cpucap
  arm64: context switch POR_EL0 register
  KVM: arm64: Save/restore POE registers
  KVM: arm64: make kvm_at() take an OP_AT_*
  KVM: arm64: use `at s1e1a` for POE
  KVM: arm64: Sanitise ID_AA64MMFR3_EL1
  arm64: enable the Permission Overlay Extension for EL0
  arm64: re-order MTE VM_ flags
  arm64: add POIndex defines
  arm64: convert protection key into vm_flags and pgprot values
  arm64: mask out POIndex when modifying a PTE
  arm64: handle PKEY/POE faults
  arm64: add pte_access_permitted_no_overlay()
  arm64: implement PKEYS support
  arm64: add POE signal support
  arm64/ptrace: add support for FEAT_POE
  arm64: enable POE and PIE to coexist
  arm64: enable PKEY support for CPUs with S1POE
  arm64: add Permission Overlay Extension Kconfig
  kselftest/arm64: move get_header()
  selftests: mm: move fpregs printing
  selftests: mm: make protection_keys test work on arm64
  kselftest/arm64: add HWCAP test for FEAT_S1POE
  kselftest/arm64: parse POE_MAGIC in a signal frame
  kselftest/arm64: Add test case for POR_EL0 signal frame records
  KVM: selftests: get-reg-list: add Permission Overlay registers

 Documentation/arch/arm64/elf_hwcaps.rst       |   2 +
 arch/arm64/Kconfig                            |  23 +++
 arch/arm64/include/asm/cpufeature.h           |   6 +
 arch/arm64/include/asm/el2_setup.h            |  10 +-
 arch/arm64/include/asm/hwcap.h                |   1 +
 arch/arm64/include/asm/kvm_asm.h              |   3 +-
 arch/arm64/include/asm/kvm_host.h             |   4 +
 arch/arm64/include/asm/mman.h                 |  10 +-
 arch/arm64/include/asm/mmu.h                  |   1 +
 arch/arm64/include/asm/mmu_context.h          |  46 +++++-
 arch/arm64/include/asm/pgtable-hwdef.h        |  10 ++
 arch/arm64/include/asm/pgtable-prot.h         |   8 +-
 arch/arm64/include/asm/pgtable.h              |  34 ++++-
 arch/arm64/include/asm/pkeys.h                | 108 ++++++++++++++
 arch/arm64/include/asm/por.h                  |  33 +++++
 arch/arm64/include/asm/processor.h            |   1 +
 arch/arm64/include/asm/sysreg.h               |   3 +
 arch/arm64/include/asm/traps.h                |   1 +
 arch/arm64/include/asm/vncr_mapping.h         |   1 +
 arch/arm64/include/uapi/asm/hwcap.h           |   1 +
 arch/arm64/include/uapi/asm/mman.h            |   9 ++
 arch/arm64/include/uapi/asm/sigcontext.h      |   7 +
 arch/arm64/kernel/cpufeature.c                |  23 +++
 arch/arm64/kernel/cpuinfo.c                   |   1 +
 arch/arm64/kernel/process.c                   |  28 ++++
 arch/arm64/kernel/ptrace.c                    |  46 ++++++
 arch/arm64/kernel/signal.c                    |  62 ++++++++
 arch/arm64/kernel/traps.c                     |   6 +
 arch/arm64/kvm/hyp/include/hyp/fault.h        |   5 +-
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h    |  27 ++++
 arch/arm64/kvm/sys_regs.c                     |  25 +++-
 arch/arm64/mm/fault.c                         |  55 ++++++-
 arch/arm64/mm/mmap.c                          |  11 ++
 arch/arm64/mm/mmu.c                           |  45 ++++++
 arch/arm64/tools/cpucaps                      |   1 +
 arch/powerpc/Kconfig                          |   4 +
 arch/x86/Kconfig                              |   4 +
 fs/proc/task_mmu.c                            |   2 +
 include/linux/mm.h                            |  20 ++-
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
 52 files changed, 1060 insertions(+), 63 deletions(-)
 create mode 100644 arch/arm64/include/asm/pkeys.h
 create mode 100644 arch/arm64/include/asm/por.h
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/poe_siginfo.c
 create mode 100644 tools/testing/selftests/mm/pkey-arm64.h

-- 
2.25.1


