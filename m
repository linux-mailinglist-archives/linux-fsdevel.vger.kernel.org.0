Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E482218706A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Mar 2020 17:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731756AbgCPQvA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Mar 2020 12:51:00 -0400
Received: from foss.arm.com ([217.140.110.172]:52022 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731414AbgCPQu7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Mar 2020 12:50:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3AF21FB;
        Mon, 16 Mar 2020 09:50:58 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 66E533F67D;
        Mon, 16 Mar 2020 09:50:58 -0700 (PDT)
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "H . J . Lu " <hjl.tools@gmail.com>,
        Andrew Jones <drjones@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        =?UTF-8?q?Kristina=20Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Weimer <fweimer@redhat.com>,
        Sudakshina Das <sudi.das@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v10 00/13] arm64: Branch Target Identification support
Date:   Mon, 16 Mar 2020 16:50:42 +0000
Message-Id: <20200316165055.31179-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series implements support for ARMv8.5-A Branch Target
Identification (BTI), which is a control flow integrity protection
feature introduced as part of the ARMv8.5-A extensions.

Changes:

v10:
 - Fix build for !COMPAT configurations.
v9:
 - Move Kconfig addition to final patch in series.
 - Add patch from Daniel Kiss adding BTI information to smaps, this has
   a trivial conflict with a .rst conversion in -next.
v8:
 - Remove a redundant IS_ENABLED(CONFIG_ARM64_BTI) check.
v7:
 - Rebase onto v5.6-rc3.
 - Move comment about keeping NT_GNU_PROPERTY_TYPE_0 internal into first
   patch.
 - Add an explicit check for system_supports_bti() when parsing BTI ELF
   property for improved robustness.
v6:
 - Rebase onto v5.6-rc1.
 - Fix typos s/BYTPE/BTYPE/ in commit log for "arm64: BTI: Decode BYTPE
   bits when printing PSTATE".
v5:
 - Changed a bunch of -EIO to -ENOEXEC in the ELF parsing code.
 - Move PSR_BTYPE defines to UAPI.
 - Use compat_user_mode() rather than open coding.
 - Fix a typo s/BYTPE/BTYPE/ in syscall.c
v4:
 - Dropped patch fixing existing documentation as it has already been merged.
 - Convert WARN_ON() to WARN_ON_ONCE() in "ELF: Add ELF program property
   parsing support".
 - Added display of guarded pages to ptdump.
 - Updated for conversion of exception handling from assembler to C.

Notes:

 * GCC 9 can compile backwards-compatible BTI-enabled code with
   -mbranch-protection=bti or -mbranch-protection=standard.

 * Binutils 2.33 and later support the new ELF note.

   Creation of a BTI-enabled binary requires _everything_ linked in to
   be BTI-enabled.  For now ld --force-bti can be used to override this,
   but some things may break until the required C library support is in
   place.

   There is no straightforward way to mark a .s file as BTI-enabled:
   scraping the output from gcc -S works as a quick hack for now.

   readelf -n can be used to examing the program properties in an ELF
   file.

 * Runtime mmap() and mprotect() can be used to enable BTI on a
   page-by-page basis using the new PROT_BTI, but the code in the
   affected pages still needs to be written or compiled to contain the
   appropriate BTI landing pads.

Daniel Kiss (1):
  mm: smaps: Report arm64 guarded pages in smaps

Dave Martin (11):
  ELF: UAPI and Kconfig additions for ELF program properties
  ELF: Add ELF program property parsing support
  arm64: Basic Branch Target Identification support
  elf: Allow arch to tweak initial mmap prot flags
  arm64: elf: Enable BTI at exec based on ELF program properties
  arm64: BTI: Decode BYTPE bits when printing PSTATE
  arm64: unify native/compat instruction skipping
  arm64: traps: Shuffle code to eliminate forward declarations
  arm64: BTI: Reset BTYPE when skipping emulated instructions
  KVM: arm64: BTI: Reset BTYPE when skipping emulated instructions
  arm64: BTI: Add Kconfig entry for userspace BTI

Mark Brown (1):
  arm64: mm: Display guarded pages in ptdump

 Documentation/arm64/cpu-feature-registers.rst |   2 +
 Documentation/arm64/elf_hwcaps.rst            |   5 +
 Documentation/filesystems/proc.txt            |   1 +
 arch/arm64/Kconfig                            |  25 +++
 arch/arm64/include/asm/cpucaps.h              |   3 +-
 arch/arm64/include/asm/cpufeature.h           |   6 +
 arch/arm64/include/asm/elf.h                  |  50 ++++++
 arch/arm64/include/asm/esr.h                  |   2 +-
 arch/arm64/include/asm/exception.h            |   1 +
 arch/arm64/include/asm/hwcap.h                |   1 +
 arch/arm64/include/asm/kvm_emulate.h          |   6 +-
 arch/arm64/include/asm/mman.h                 |  37 +++++
 arch/arm64/include/asm/pgtable-hwdef.h        |   1 +
 arch/arm64/include/asm/pgtable.h              |   2 +-
 arch/arm64/include/asm/ptrace.h               |   1 +
 arch/arm64/include/asm/sysreg.h               |   4 +
 arch/arm64/include/uapi/asm/hwcap.h           |   1 +
 arch/arm64/include/uapi/asm/mman.h            |   9 ++
 arch/arm64/include/uapi/asm/ptrace.h          |   9 ++
 arch/arm64/kernel/cpufeature.c                |  33 ++++
 arch/arm64/kernel/cpuinfo.c                   |   1 +
 arch/arm64/kernel/entry-common.c              |  11 ++
 arch/arm64/kernel/process.c                   |  36 ++++-
 arch/arm64/kernel/ptrace.c                    |   2 +-
 arch/arm64/kernel/signal.c                    |  16 ++
 arch/arm64/kernel/syscall.c                   |  18 +++
 arch/arm64/kernel/traps.c                     | 131 ++++++++--------
 arch/arm64/mm/dump.c                          |   5 +
 fs/Kconfig.binfmt                             |   6 +
 fs/binfmt_elf.c                               | 145 +++++++++++++++++-
 fs/compat_binfmt_elf.c                        |   4 +
 fs/proc/task_mmu.c                            |   3 +
 include/linux/elf.h                           |  43 ++++++
 include/linux/mm.h                            |   3 +
 include/uapi/linux/elf.h                      |  11 ++
 35 files changed, 560 insertions(+), 74 deletions(-)
 create mode 100644 arch/arm64/include/asm/mman.h
 create mode 100644 arch/arm64/include/uapi/asm/mman.h


base-commit: f8788d86ab28f61f7b46eb6be375f8a726783636
-- 
2.20.1

