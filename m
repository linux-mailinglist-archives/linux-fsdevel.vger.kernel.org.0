Return-Path: <linux-fsdevel+bounces-30520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C9898C24C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 18:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120C91C23A18
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 16:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E3B1CB532;
	Tue,  1 Oct 2024 16:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="EATPRsyy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B2F1CB50F
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Oct 2024 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727798822; cv=none; b=WaI4AXfVEjwlxMrg6tMuOC2epCOod5an3gUpDZlxOaWQTejfQcv8GcmRtKdNW0UoM3LFfBIzXifFbfG9NSdjl2KFbyrUsqPk/jg0nTMciDxWIvHAqrWK0RCWeoXCVNBxdaRKxmrVsIutZW2cBeS9VbCc7gnaKfhJtxNzsdAjM3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727798822; c=relaxed/simple;
	bh=m0FIsgogONUZNmfchDshFIQ0w4NVb3xrsAQwcxIIjy4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XlKWP2+6c1fGTjtPuyba1fWMDZavAzVnXD7PDJlDXWCqMumyw86bjarBGNpQSyjxNOuSv93qohMh3AyX4n3rHiuegqStZrjrFuRdz7KfFDOuzPJRW7Z3a/ZbNzAy9/x5Pr9jVuDsXiM2iAWZE0ZwS3g+EOM24V3JZ2deKNBD5+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=EATPRsyy; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e09d9f2021so3822770a91.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Oct 2024 09:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1727798819; x=1728403619; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p/+CAfw719K7trKUOdaKnGov4VX+rClpCqrk7kv+YBo=;
        b=EATPRsyyj2q81GehYdkE/ZPRkVpxUhaGQPNLwl5bQNm46SaY8JdKO1nQfezQO+L3C+
         pa1hJX2R2MlKtDJ8uycgj5oUbZagsgL9ik0quQ5TyaHiBwDr1iJ000m/+gZ7H1TeQcm1
         4XtRyWCv1JFRn8dIHkUj6nD1kPc9NZUKyt8CDWDAOtT8mWcyLa0lwwR37CkZ16DXZxgS
         wIdN6osroeGGZhncvNLCOVFHDdtI9DjVw5KW2QVC2QeIBNxQ+QCMErY1LExVTkbAh9rl
         /nGEHP5WAy2wd1a0YoKs9111yc/4//iwyjdkXwnn24JDzdJm6FefeSiTWOGweXFrRmGk
         QBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727798819; x=1728403619;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p/+CAfw719K7trKUOdaKnGov4VX+rClpCqrk7kv+YBo=;
        b=Yd54oWwcSS2wkgdwlvANlM6xqxfYDu5AO4PcQmY67ma3Mer7XgOfoTOuIMO8Suf8Gn
         4d0S5YHeDb7sNpvzQnuavEQyeO0vJb2Nu3lYPAGsrq0eDrzE+l/NCqj6uX5558bB+Axm
         H6QfMdZd4USe0T969YidLkqbQCbWdDFveKA8MtrlRHwIRJVLEXa9qF5QTTCsD/YRJGP3
         CD4ThuPXDFch4qDUFDtXNhZqIQ5/ypn/l1f2b2qoU3Nd9IlyZbvp/f/0mvIpgpdXkQ9Y
         fabzYIUz1y83dEM5cNuD+7QhKLBHGpCFwngGRqmXVP1TJeBn+NgxUzWKoG92qJEdj9v9
         oQfw==
X-Forwarded-Encrypted: i=1; AJvYcCWwfY681ld9y5ynm6nchk6asqO8VjFrs2JB63qXA8SBK53UBkA48JgQqlE3xznWW40mffTHRMG2MCkCCpJJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwDlHI0etPOp44fm5bWJcUTfv7hMWo8dzK6ZlNJedNon6O4apRX
	p2dvX3qkifIk3o+GVewewNni0AV0Bi/eWOPCQ4erXRJKik/Grate9TPHzr/iKqQ=
X-Google-Smtp-Source: AGHT+IEN2dus5eCDv3FJ6JG+o53WejlfJ1X7DX0j+cv1B0CFXJtJs/0I33VncpmVbaQmMUBwG53XiQ==
X-Received: by 2002:a17:90b:46cd:b0:2d3:ba42:775c with SMTP id 98e67ed59e1d1-2e184521a79mr281772a91.1.1727798818585;
        Tue, 01 Oct 2024 09:06:58 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e1d7d47sm13843973a91.28.2024.10.01.09.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 09:06:58 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH 00/33] riscv control-flow integrity for usermode
Date: Tue, 01 Oct 2024 09:06:05 -0700
Message-Id: <20241001-v5_user_cfi_series-v1-0-3ba65b6e550f@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAO0d/GYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDS2MD3TLT+FKgnvjktMx4iF5d45RkY2OjNIs00yQjJaDGgqLUtMwKsKH
 RsbW1ALWj2ONkAAAA
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, Deepak Gupta <debug@rivosinc.com>, 
 David Hildenbrand <david@redhat.com>, 
 Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Andrew Jones <ajones@ventanamicro.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Andy Chiu <andy.chiu@sifive.com>
X-Mailer: b4 0.14.0

v5 for cpu assisted riscv user mode control flow integrity.
zicfiss and zicfilp [1] are ratified riscv CPU extensions.

Changes in this version are
- rebased on v6.12-rc1
- Fixed schema related issues in device tree file
- Fixed some of the documentation related issues in zicfilp/ss.rst
  (style issues and added index)
- added `SHADOW_STACK_SET_MARKER` so that implementation can define base
  of shadow stack.
- Fixed warnings on definitions added in usercfi.h when
  CONFIG_RISCV_USER_CFI is not selected.
- Adopted context header based signal handling as proposed by Andy Chiu
- Added support for enabling kernel mode access to shadow stack using
  FWFT [4]

v4 [3] and v3 [2] are earlier versions of patch series.

To get more information on kernel interactions with respect to
zicfilp and zicfiss, patch series adds documentation for
`zicfilp` and `zicfiss`

Documentation/arch/riscv/zicfiss.rst
Documentation/arch/riscv/zicfilp.rst

How to test this series
=======================

Toolchain
---------
$ git clone git@github.com:sifive/riscv-gnu-toolchain.git -b cfi-dev
$ riscv-gnu-toolchain/configure --prefix=<path-to-where-to-build> --with-arch=rv64gc_zicfilp_zicfiss --enable-linux --disable-gdb  --with-extra-multilib-test="rv64gc_zicfilp_zicfiss-lp64d:-static"
$ make -j$(nproc)

Qemu
----
$ git clone git@github.com:deepak0414/qemu.git -b zicfilp_zicfiss_ratified_master_july11
$ cd qemu
$ mkdir build
$ cd build
$ ../configure --target-list=riscv64-softmmu
$ make -j$(nproc)

Opensbi
-------
$ git clone git@github.com:deepak0414/opensbi.git -b v6_cfi_spec_split_opensbi
$ make CROSS_COMPILE=<your riscv toolchain> -j$(nproc) PLATFORM=generic

Linux
-----
Running defconfig is fine. CFI is enabled by default if the toolchain
supports it.

$ make ARCH=riscv CROSS_COMPILE=<path-to-cfi-riscv-gnu-toolchain>/build/bin/riscv64-unknown-linux-gnu- -j$(nproc) defconfig
$ make ARCH=riscv CROSS_COMPILE=<path-to-cfi-riscv-gnu-toolchain>/build/bin/riscv64-unknown-linux-gnu- -j$(nproc)

Running
-------

Modify your qemu command to have:
-bios <path-to-cfi-opensbi>/build/platform/generic/firmware/fw_dynamic.bin
-cpu rv64,zicfilp=true,zicfiss=true,zimop=true,zcmop=true

vDSO related Opens (in the flux)
=================================

I am listing these opens for laying out plan and what to expect in future
patch sets. And of course for the sake of discussion.

Shadow stack and landing pad enabling in vDSO
----------------------------------------------
vDSO must have shadow stack and landing pad support compiled in for task
to have shadow stack and landing pad support. This patch series doesn't
enable that (yet). Enabling shadow stack support in vDSO should be
straight forward (intend to do that in next versions of patch set). Enabling
landing pad support in vDSO requires some collaboration with toolchain folks
to follow a single label scheme for all object binaries. This is necessary to
ensure that all indirect call-sites are setting correct label and target landing
pads are decorated with same label scheme.

How many vDSOs
---------------
Shadow stack instructions are carved out of zimop (may be operations) and if CPU
doesn't implement zimop, they're illegal instructions. Kernel could be running on
a CPU which may or may not implement zimop. And thus kernel will have to carry 2
different vDSOs and expose the appropriate one depending on whether CPU implements
zimop or not.

[1] - https://github.com/riscv/riscv-cfi
[2] - https://lore.kernel.org/lkml/20240403234054.2020347-1-debug@rivosinc.com/
[3] - https://lore.kernel.org/all/20240912231650.3740732-1-debug@rivosinc.com/
[4] - https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/src/ext-firmware-features.adoc

---
changelog
---------

v4
--
- rebased on 6.11-rc6
- envcfg: Converged with Samuel Holland's patches for envcfg management on per-
thread basis.
- vma_is_shadow_stack is renamed to is_vma_shadow_stack
- picked up Mark Brown's `ARCH_HAS_USER_SHADOW_STACK` patch
- signal context: using extended context management to maintain compatibility.
- fixed `-Wmissing-prototypes` compiler warnings for prctl functions
- Documentation fixes and amending typos.

v3
--
envcfg:
logic to pick up base envcfg had a bug where `ENVCFG_CBZE` could have been
picked on per task basis, even though CPU didn't implement it. Fixed in
this series.

dt-bindings:
As suggested, split into separate commit. fixed the messaging that spec is
in public review

arch_is_shadow_stack change:
arch_is_shadow_stack changed to vma_is_shadow_stack

hwprobe:
zicfiss / zicfilp if present will get enumerated in hwprobe

selftests:
As suggested, added object and binary filenames to .gitignore
Selftest binary anyways need to be compiled with cfi enabled compiler which
will make sure that landing pad and shadow stack are enabled. Thus removed
separate enable/disable tests. Cleaned up tests a bit.

v2
--

- Using config `CONFIG_RISCV_USER_CFI`, kernel support for riscv control flow
integrity for user mode programs can be compiled in the kernel.

- Enabling of control flow integrity for user programs is left to user runtime

- This patch series introduces arch agnostic `prctls` to enable shadow stack
and indirect branch tracking. And implements them on riscv.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>

---
Andy Chiu (1):
      riscv: signal: abstract header saving for setup_sigcontext

Clément Léger (1):
      riscv: Add Firmware Feature SBI extensions definitions

Deepak Gupta (26):
      mm: helper `is_shadow_stack_vma` to check shadow stack vma
      riscv/Kconfig: enable HAVE_EXIT_THREAD for riscv
      riscv: zicfilp / zicfiss in dt-bindings (extensions.yaml)
      riscv: zicfiss / zicfilp enumeration
      riscv: zicfiss / zicfilp extension csr and bit definitions
      riscv: usercfi state for task and save/restore of CSR_SSP on trap entry/exit
      riscv/mm : ensure PROT_WRITE leads to VM_READ | VM_WRITE
      riscv mm: manufacture shadow stack pte
      riscv mmu: teach pte_mkwrite to manufacture shadow stack PTEs
      riscv mmu: write protect and shadow stack
      riscv/mm: Implement map_shadow_stack() syscall
      riscv/shstk: If needed allocate a new shadow stack on clone
      prctl: arch-agnostic prctl for indirect branch tracking
      riscv: Implements arch agnostic shadow stack prctls
      riscv: Implements arch agnostic indirect branch tracking prctls
      riscv/traps: Introduce software check exception
      riscv signal: save and restore of shadow stack for signal
      riscv/kernel: update __show_regs to print shadow stack register
      riscv/ptrace: riscv cfi status and state via ptrace and in core files
      riscv/hwprobe: zicfilp / zicfiss enumeration in hwprobe
      riscv: enable kernel access to shadow stack memory via FWFT sbi call
      riscv: kernel command line option to opt out of user cfi
      riscv: create a config for shadow stack and landing pad instr support
      riscv: Documentation for landing pad / indirect branch tracking
      riscv: Documentation for shadow stack on riscv
      kselftest/riscv: kselftest for user mode cfi

Mark Brown (2):
      mm: Introduce ARCH_HAS_USER_SHADOW_STACK
      prctl: arch-agnostic prctl for shadow stack

Samuel Holland (3):
      riscv: Enable cbo.zero only when all harts support Zicboz
      riscv: Add support for per-thread envcfg CSR values
      riscv: Call riscv_user_isa_enable() only on the boot hart

 Documentation/arch/riscv/index.rst                 |   2 +
 Documentation/arch/riscv/zicfilp.rst               | 115 +++++
 Documentation/arch/riscv/zicfiss.rst               | 176 +++++++
 .../devicetree/bindings/riscv/extensions.yaml      |  14 +
 arch/riscv/Kconfig                                 |  20 +
 arch/riscv/include/asm/asm-prototypes.h            |   1 +
 arch/riscv/include/asm/cpufeature.h                |  15 +-
 arch/riscv/include/asm/csr.h                       |  16 +
 arch/riscv/include/asm/entry-common.h              |   2 +
 arch/riscv/include/asm/hwcap.h                     |   2 +
 arch/riscv/include/asm/mman.h                      |  24 +
 arch/riscv/include/asm/pgtable.h                   |  30 +-
 arch/riscv/include/asm/processor.h                 |   2 +
 arch/riscv/include/asm/sbi.h                       |  27 ++
 arch/riscv/include/asm/switch_to.h                 |   8 +
 arch/riscv/include/asm/thread_info.h               |   4 +
 arch/riscv/include/asm/usercfi.h                   |  89 ++++
 arch/riscv/include/uapi/asm/hwprobe.h              |   2 +
 arch/riscv/include/uapi/asm/ptrace.h               |  22 +
 arch/riscv/include/uapi/asm/sigcontext.h           |   1 +
 arch/riscv/kernel/Makefile                         |   2 +
 arch/riscv/kernel/asm-offsets.c                    |   8 +
 arch/riscv/kernel/cpufeature.c                     |  13 +-
 arch/riscv/kernel/entry.S                          |  31 +-
 arch/riscv/kernel/head.S                           |  12 +
 arch/riscv/kernel/process.c                        |  31 +-
 arch/riscv/kernel/ptrace.c                         |  83 ++++
 arch/riscv/kernel/signal.c                         | 140 +++++-
 arch/riscv/kernel/smpboot.c                        |   2 -
 arch/riscv/kernel/suspend.c                        |   4 +-
 arch/riscv/kernel/sys_hwprobe.c                    |   2 +
 arch/riscv/kernel/sys_riscv.c                      |  10 +
 arch/riscv/kernel/traps.c                          |  42 ++
 arch/riscv/kernel/usercfi.c                        | 526 +++++++++++++++++++++
 arch/riscv/mm/init.c                               |   2 +-
 arch/riscv/mm/pgtable.c                            |  17 +
 arch/x86/Kconfig                                   |   1 +
 fs/proc/task_mmu.c                                 |   2 +-
 include/linux/cpu.h                                |   4 +
 include/linux/mm.h                                 |   5 +-
 include/uapi/asm-generic/mman.h                    |   4 +
 include/uapi/linux/elf.h                           |   1 +
 include/uapi/linux/prctl.h                         |  48 ++
 kernel/sys.c                                       |  60 +++
 mm/Kconfig                                         |   6 +
 mm/gup.c                                           |   2 +-
 mm/mmap.c                                          |   1 +
 mm/vma.h                                           |  10 +-
 tools/testing/selftests/riscv/Makefile             |   2 +-
 tools/testing/selftests/riscv/cfi/.gitignore       |   3 +
 tools/testing/selftests/riscv/cfi/Makefile         |  10 +
 tools/testing/selftests/riscv/cfi/cfi_rv_test.h    |  83 ++++
 tools/testing/selftests/riscv/cfi/riscv_cfi_test.c |  82 ++++
 tools/testing/selftests/riscv/cfi/shadowstack.c    | 362 ++++++++++++++
 tools/testing/selftests/riscv/cfi/shadowstack.h    |  37 ++
 55 files changed, 2178 insertions(+), 42 deletions(-)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20240930-v5_user_cfi_series-3dc332f8f5b2
--
- debug


