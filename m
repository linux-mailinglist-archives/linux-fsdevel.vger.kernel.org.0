Return-Path: <linux-fsdevel+bounces-29230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5904B9774C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 01:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D07631F24E5B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 23:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E825B1C32F7;
	Thu, 12 Sep 2024 23:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="dExmhiCz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFF419F402
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 23:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726183029; cv=none; b=aGKzu5a3Bi1neg5qlcXW6NXuELKJcTFsTfGXVtJT0RCvKhaZRwzkyACF84qiURg8+CGOjbC8DzWz+kBSw6HzBxiqxvy72ZUUNF7VPlGB8lf0eqIZBD81lAWbdrq9ifgAVsv7ib8XPROA89/mBU2Grlt1rGbjQ4Auk4aaXdiSgk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726183029; c=relaxed/simple;
	bh=e3w83ZOFG/14yXpfgumi01jxJD0wxKURECNyvQAyYZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QA7kz2lwCJhsUbEd4Kyei9wA7T3Vy6IXgvNmr+HQct+ndEWaWHDyL617TSNVZNWGeM9kty/cT2wsJveeI2MO7HXzabMm7krzNS/2xGEBIb3EHV8cOm3Y2qgkhSyH5LA90p8y5yfCu3IkNldNOu1z7lFmQ/11Po8w4YiDkZ5b3x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=dExmhiCz; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d87a0bfaa7so313358a91.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 16:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726183026; x=1726787826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=riewyPvOkd6+yywyzaWDXE1UC6COJKG1le8303PRl2M=;
        b=dExmhiCz98tFZjE8KYPDrSJTK4uSkoEJw1t1oPJVQQqdpk71vrNXpeNzk71H3XVMDE
         lOKd+Mk4ybsXCvaM8tYuX8yejiZELnszaCiPH13JafkmYfhD2wx6Zfs0vGgfKD72q0ui
         RCaF9td2G9dCC5cHHOiY4GpYItz3SnaFSe44WHYF2ifhdBtO50u4hf1N5o8SSfj7kDlQ
         a7Xo4xcwCJnFQC8pYCZfjxIzgStKvrCNgU4Q/IE2woEhDwZQPZOrt/Acn7ymf9JnR1OR
         mUo0jeR+RCApMmaaC9zczleBKxv1jFd5qQMnwEo4XL68oqNowyBuRaJFKZDb+1PYhIQe
         CZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726183026; x=1726787826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=riewyPvOkd6+yywyzaWDXE1UC6COJKG1le8303PRl2M=;
        b=HO2mA8QL3M5sRboEr9TAc9xKkZLesQnNZS2bf5ed1Xmpeu+/XRSFMz4rmE2zrrbWOb
         gt0DmPzZTQ8k6AIy39bt3E6vVj7yoyMW1nDpjasJsG6CZbdWotr6evl4UaR5U1a3ObEi
         nN+hLjqRRzdW3WghJYgKoce1kNfcbROHISr6CqShCowdNq0+bbnixF7nPbz9Ns1vDg/i
         7ngvFMxp1DpguX45hanuSuav5cfvfJxZVT0GIeChWNjZhgDBqvCqKwcCheqdmdTyaeyV
         hhkPbkGR2dmX7eterw5XVP2hUqSy6zLY4tfg1g0kYBlsHr2q8bBFRe2Axf9mFMhlxLHh
         TXyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWef8QT1OWPm63RZSP/LMJSB/DEFpVyTVLf2j5ZB67GbpJys8fnEPbM9LF3P+mxm2Zn+crbRNqGgneIiYM@vger.kernel.org
X-Gm-Message-State: AOJu0YyHgAvi2sIkDGXwU/Xk7FLcQyWiZAqEqYAcHvrexMW3dm5dt1Ur
	HA5OUwQ0Wozr6IbqAacv9dz/htoQgwUpkYVPdcZDG8YtJZVoRSUcVBfZRu6qVHs=
X-Google-Smtp-Source: AGHT+IG3UlKSJNA+0+xwU2A+yWN3j878ej9hqq8AW6JPwgouwb7JofjBAbMeGmJ3FwYyI2jaMifNow==
X-Received: by 2002:a17:90b:4f91:b0:2d3:cd27:c480 with SMTP id 98e67ed59e1d1-2dbb9f7d558mr1060297a91.33.1726183025514;
        Thu, 12 Sep 2024 16:17:05 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db6c1ac69asm3157591a91.0.2024.09.12.16.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 16:17:05 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: paul.walmsley@sifive.com,
	palmer@sifive.com,
	conor@kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: corbet@lwn.net,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh@kernel.org,
	krzk+dt@kernel.org,
	oleg@redhat.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	peterz@infradead.org,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	ebiederm@xmission.com,
	kees@kernel.org,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	shuah@kernel.org,
	brauner@kernel.org,
	samuel.holland@sifive.com,
	debug@rivosinc.com,
	andy.chiu@sifive.com,
	jerry.shih@sifive.com,
	greentime.hu@sifive.com,
	charlie@rivosinc.com,
	evan@rivosinc.com,
	cleger@rivosinc.com,
	xiao.w.wang@intel.com,
	ajones@ventanamicro.com,
	anup@brainfault.org,
	mchitale@ventanamicro.com,
	atishp@rivosinc.com,
	sameo@rivosinc.com,
	bjorn@rivosinc.com,
	alexghiti@rivosinc.com,
	david@redhat.com,
	libang.li@antgroup.com,
	jszhang@kernel.org,
	leobras@redhat.com,
	guoren@kernel.org,
	samitolvanen@google.com,
	songshuaishuai@tinylab.org,
	costa.shul@redhat.com,
	bhe@redhat.com,
	zong.li@sifive.com,
	puranjay@kernel.org,
	namcaov@gmail.com,
	antonb@tenstorrent.com,
	sorear@fastmail.com,
	quic_bjorande@quicinc.com,
	ancientmodern4@gmail.com,
	ben.dooks@codethink.co.uk,
	quic_zhonhan@quicinc.com,
	cuiyunhui@bytedance.com,
	yang.lee@linux.alibaba.com,
	ke.zhao@shingroup.cn,
	sunilvl@ventanamicro.com,
	tanzhasanwork@gmail.com,
	schwab@suse.de,
	dawei.li@shingroup.cn,
	rppt@kernel.org,
	willy@infradead.org,
	usama.anjum@collabora.com,
	osalvador@suse.de,
	ryan.roberts@arm.com,
	andrii@kernel.org,
	alx@kernel.org,
	catalin.marinas@arm.com,
	broonie@kernel.org,
	revest@chromium.org,
	bgray@linux.ibm.com,
	deller@gmx.de,
	zev@bewilderbeest.net
Subject: [PATCH v4 00/30] riscv control-flow integrity for usermode
Date: Thu, 12 Sep 2024 16:16:19 -0700
Message-ID: <20240912231650.3740732-1-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v4 for cpu assisted riscv user mode control flow integrity.
zicfiss and zicfilp [1] are ratified riscv CPU extensions.

v3 [2] was sent in April this year for riscv usermode control
flow integrity enabling.

To get more information on zicfilp and zicfiss riscv CPU extensions,
patch series adds documentation for `zicfilp` and `zicfiss`
Documentation/arch/riscv/zicfiss.rst
Documentation/arch/riscv/zicfilp.rst

Additionally, spec can be obtained from [1].

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
$ git clone git@github.com:deepak0414/opensbi.git -b cfi_spec_split_opensbi
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

Deepak Gupta (25):
  mm: helper `is_shadow_stack_vma` to check shadow stack vma
  riscv/Kconfig: enable HAVE_EXIT_THREAD for riscv
  riscv: zicfilp / zicfiss in dt-bindings (extensions.yaml)
  riscv: zicfiss / zicfilp enumeration
  riscv: zicfiss / zicfilp extension csr and bit definitions
  riscv: usercfi state for task and save/restore of CSR_SSP on trap
    entry/exit
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
  riscv sigcontext: cfi state struct definition for sigcontext
  riscv signal: save and restore of shadow stack for signal
  riscv/kernel: update __show_regs to print shadow stack register
  riscv/ptrace: riscv cfi status and state via ptrace and in core files
  riscv/hwprobe: zicfilp / zicfiss enumeration in hwprobe
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

 Documentation/arch/riscv/zicfilp.rst          | 104 ++++
 Documentation/arch/riscv/zicfiss.rst          | 169 ++++++
 .../devicetree/bindings/riscv/extensions.yaml |  12 +
 arch/riscv/Kconfig                            |  20 +
 arch/riscv/include/asm/asm-prototypes.h       |   1 +
 arch/riscv/include/asm/cpufeature.h           |  15 +-
 arch/riscv/include/asm/csr.h                  |  16 +
 arch/riscv/include/asm/entry-common.h         |   2 +
 arch/riscv/include/asm/hwcap.h                |   2 +
 arch/riscv/include/asm/mman.h                 |  24 +
 arch/riscv/include/asm/pgtable.h              |  30 +-
 arch/riscv/include/asm/processor.h            |   2 +
 arch/riscv/include/asm/switch_to.h            |   8 +
 arch/riscv/include/asm/thread_info.h          |   4 +
 arch/riscv/include/asm/usercfi.h              | 142 +++++
 arch/riscv/include/uapi/asm/hwprobe.h         |   2 +
 arch/riscv/include/uapi/asm/ptrace.h          |  18 +
 arch/riscv/include/uapi/asm/sigcontext.h      |   3 +
 arch/riscv/kernel/Makefile                    |   2 +
 arch/riscv/kernel/asm-offsets.c               |   4 +
 arch/riscv/kernel/cpufeature.c                |  13 +-
 arch/riscv/kernel/entry.S                     |  29 +
 arch/riscv/kernel/process.c                   |  32 +-
 arch/riscv/kernel/ptrace.c                    |  83 +++
 arch/riscv/kernel/signal.c                    |  62 ++-
 arch/riscv/kernel/smpboot.c                   |   2 -
 arch/riscv/kernel/suspend.c                   |   4 +-
 arch/riscv/kernel/sys_hwprobe.c               |   2 +
 arch/riscv/kernel/sys_riscv.c                 |  10 +
 arch/riscv/kernel/traps.c                     |  38 ++
 arch/riscv/kernel/usercfi.c                   | 506 ++++++++++++++++++
 arch/riscv/mm/init.c                          |   2 +-
 arch/riscv/mm/pgtable.c                       |  17 +
 arch/x86/Kconfig                              |   1 +
 fs/proc/task_mmu.c                            |   2 +-
 include/linux/cpu.h                           |   4 +
 include/linux/mm.h                            |  12 +-
 include/uapi/asm-generic/mman.h               |   1 +
 include/uapi/linux/elf.h                      |   1 +
 include/uapi/linux/prctl.h                    |  48 ++
 kernel/sys.c                                  |  60 +++
 mm/Kconfig                                    |   6 +
 mm/gup.c                                      |   2 +-
 mm/internal.h                                 |   2 +-
 mm/mmap.c                                     |   1 +
 tools/testing/selftests/riscv/Makefile        |   2 +-
 tools/testing/selftests/riscv/cfi/.gitignore  |   3 +
 tools/testing/selftests/riscv/cfi/Makefile    |  10 +
 .../testing/selftests/riscv/cfi/cfi_rv_test.h |  83 +++
 .../selftests/riscv/cfi/riscv_cfi_test.c      |  82 +++
 .../testing/selftests/riscv/cfi/shadowstack.c | 362 +++++++++++++
 .../testing/selftests/riscv/cfi/shadowstack.h |  37 ++
 52 files changed, 2079 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/arch/riscv/zicfilp.rst
 create mode 100644 Documentation/arch/riscv/zicfiss.rst
 create mode 100644 arch/riscv/include/asm/mman.h
 create mode 100644 arch/riscv/include/asm/usercfi.h
 create mode 100644 arch/riscv/kernel/usercfi.c
 create mode 100644 tools/testing/selftests/riscv/cfi/.gitignore
 create mode 100644 tools/testing/selftests/riscv/cfi/Makefile
 create mode 100644 tools/testing/selftests/riscv/cfi/cfi_rv_test.h
 create mode 100644 tools/testing/selftests/riscv/cfi/riscv_cfi_test.c
 create mode 100644 tools/testing/selftests/riscv/cfi/shadowstack.c
 create mode 100644 tools/testing/selftests/riscv/cfi/shadowstack.h

-- 
2.45.0


