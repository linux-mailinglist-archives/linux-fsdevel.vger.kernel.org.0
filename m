Return-Path: <linux-fsdevel+bounces-18611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8EE8BACF3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 15:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FD7C1C219B9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 13:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A6615380B;
	Fri,  3 May 2024 13:02:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653BA152E17
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 May 2024 13:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714741319; cv=none; b=TchGaSNCsYxhjjxhZacAKIxtANhizydaaJSB+bRJ5JTviD4P1OszU+DUfQrwytSgFCeZH8AT79sycQ/6cSWkk+jyn2Xft5d7ehDcAF0dPER4CU1iKITV4hQbXN0D8klFX0Gtha4aHNWwFeNEWv98tozgsG3AVBFGrXfcrBcu26M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714741319; c=relaxed/simple;
	bh=W/lV2Nj3/FREdBkCCTpq9jz8LLf8zh6r/sj6RQTo4kU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AvT+D1yl+xEi3FIWBd/TG3hBq7FOkmXqkHquLPywPQfgdfrV8A7VUxWK7E4PxcWDToP1ojl76CLwMdCDYM4De+tdxbwYk8EDsxBNRanMO5P9XwruG138qfRcvBN5nDtWtoiTGft6Ogx7Duwd6Mkh9GV508+6jkMVSMxbxinw4aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC3E013D5;
	Fri,  3 May 2024 06:02:20 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7777C3F73F;
	Fri,  3 May 2024 06:01:52 -0700 (PDT)
From: Joey Gouly <joey.gouly@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: akpm@linux-foundation.org,
	aneesh.kumar@kernel.org,
	aneesh.kumar@linux.ibm.com,
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
	szabolcs.nagy@arm.com,
	tglx@linutronix.de,
	will@kernel.org,
	x86@kernel.org,
	kvmarm@lists.linux.dev
Subject: [PATCH v4 00/29] arm64: Permission Overlay Extension
Date: Fri,  3 May 2024 14:01:18 +0100
Message-Id: <20240503130147.1154804-1-joey.gouly@arm.com>
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
VMSA enhancements [1]. It is based on v6.9-rc5.

One possible issue with this version, I took the last bit of HWCAP2.

Changes since v3[2]:
	- Moved Kconfig to nearer the end of the series
	- Reworked MMU Fault path, to check for POE faults earlier, under the mm lock
	- Rework VM_FLAGS to use Kconfig option
	- Don't check POR_EL0 in MTE sync tags function
	- Reworked KVM to fit into VNCR/VM configuration changes
	- Use new AT instruction in KVM
	- Rebase onto v6.9-rc5

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

Joey Gouly (29):
  powerpc/mm: add ARCH_PKEY_BITS to Kconfig
  x86/mm: add ARCH_PKEY_BITS to Kconfig
  mm: use ARCH_PKEY_BITS to define VM_PKEY_BITN
  arm64: disable trapping of POR_EL0 to EL2
  arm64: cpufeature: add Permission Overlay Extension cpucap
  arm64: context switch POR_EL0 register
  KVM: arm64: Save/restore POE registers
  KVM: arm64: make kvm_at() take an OP_AT_*
  KVM: arm64: use `at s1e1a` for POE
  arm64: enable the Permission Overlay Extension for EL0
  arm64: re-order MTE VM_ flags
  arm64: add POIndex defines
  arm64: convert protection key into vm_flags and pgprot values
  arm64: mask out POIndex when modifying a PTE
  arm64: handle PKEY/POE faults
  arm64: add pte_access_permitted_no_overlay()
  arm64: implement PKEYS support
  arm64: add POE signal support
  arm64: enable PKEY support for CPUs with S1POE
  arm64: enable POE and PIE to coexist
  arm64/ptrace: add support for FEAT_POE
  arm64: add Permission Overlay Extension Kconfig
  kselftest/arm64: move get_header()
  selftests: mm: move fpregs printing
  selftests: mm: make protection_keys test work on arm64
  kselftest/arm64: add HWCAP test for FEAT_S1POE
  kselftest/arm64: parse POE_MAGIC in a signal frame
  kselftest/arm64: Add test case for POR_EL0 signal frame records
  KVM: selftests: get-reg-list: add Permission Overlay registers

 Documentation/arch/arm64/elf_hwcaps.rst       |   2 +
 arch/arm64/Kconfig                            |  22 +++
 arch/arm64/include/asm/cpufeature.h           |   6 +
 arch/arm64/include/asm/el2_setup.h            |  10 +-
 arch/arm64/include/asm/hwcap.h                |   1 +
 arch/arm64/include/asm/kvm_asm.h              |   3 +-
 arch/arm64/include/asm/kvm_host.h             |   4 +
 arch/arm64/include/asm/mman.h                 |   8 +-
 arch/arm64/include/asm/mmu.h                  |   1 +
 arch/arm64/include/asm/mmu_context.h          |  51 ++++++-
 arch/arm64/include/asm/pgtable-hwdef.h        |  10 ++
 arch/arm64/include/asm/pgtable-prot.h         |   8 +-
 arch/arm64/include/asm/pgtable.h              |  34 ++++-
 arch/arm64/include/asm/pkeys.h                | 110 ++++++++++++++
 arch/arm64/include/asm/por.h                  |  33 +++++
 arch/arm64/include/asm/processor.h            |   1 +
 arch/arm64/include/asm/sysreg.h               |   3 +
 arch/arm64/include/asm/traps.h                |   1 +
 arch/arm64/include/asm/vncr_mapping.h         |   1 +
 arch/arm64/include/uapi/asm/hwcap.h           |   1 +
 arch/arm64/include/uapi/asm/sigcontext.h      |   7 +
 arch/arm64/kernel/cpufeature.c                |  23 +++
 arch/arm64/kernel/cpuinfo.c                   |   1 +
 arch/arm64/kernel/process.c                   |  28 ++++
 arch/arm64/kernel/ptrace.c                    |  46 ++++++
 arch/arm64/kernel/signal.c                    |  52 +++++++
 arch/arm64/kernel/traps.c                     |  12 +-
 arch/arm64/kvm/hyp/include/hyp/fault.h        |   5 +-
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h    |  29 ++++
 arch/arm64/kvm/sys_regs.c                     |   8 +-
 arch/arm64/mm/fault.c                         |  56 ++++++-
 arch/arm64/mm/mmap.c                          |   9 ++
 arch/arm64/mm/mmu.c                           |  40 +++++
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
 51 files changed, 1027 insertions(+), 66 deletions(-)
 create mode 100644 arch/arm64/include/asm/pkeys.h
 create mode 100644 arch/arm64/include/asm/por.h
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/poe_siginfo.c
 create mode 100644 tools/testing/selftests/mm/pkey-arm64.h

-- 
2.25.1


