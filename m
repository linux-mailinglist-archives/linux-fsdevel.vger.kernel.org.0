Return-Path: <linux-fsdevel+bounces-40866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 980A4A280A7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 02:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56C281887C82
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 01:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8588C227BA2;
	Wed,  5 Feb 2025 01:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Un9vUBt2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C6725A63B
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 01:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738718516; cv=none; b=sLsWM+KOOB7RM4ThzzdiEUkoyH+8SCRPYxE/MK11p0rUu7MRDVt+2/JQ0w6groMlfGxxgxFsTAM7KJTRUe0cMM6fYYRdtR5oayQGwLtc5uB5ApiOPBggol+zfc7CnnKJwGMxYCkIc8YR27acZgHkcaoDE3dvvvrZLWJvw/v9bxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738718516; c=relaxed/simple;
	bh=W4v82jeQ22Pz6GyT+jYcfnMYgeyfCPALxxXS3GQSCcY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IPYUAkU5/WG5Pq4mO+tclsDrlhaqph1rsDV+YbZbTw0WBdX+z+hNxZ1qGHiP9n3JUNOOArV4av5g34lrc465JBwXcnLv3SvnvLXXWpWpDnlhnHpGRdgegOClpJB6odbcgu1QXD18mZcaeqw0/7fLC+wY0rkPmOMgMmjHWXJKymw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Un9vUBt2; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2f44353649aso8334062a91.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2025 17:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738718514; x=1739323314; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WAelabJsFDQCp6OSdU0Y7aOri7VRZ4IciM6Wd7w26sc=;
        b=Un9vUBt2hNGP9TEkE6D71VLewkxBjOc0mH+Czecc7gq5G9GmXoDrBmkonn3QDznRKl
         o+kE4hQ4MuyRDZwV/qoGX6NaOR8cGu3PYOa3m7NhDigJc/NEA1mhFwQiXmMJZkfkIzMN
         BLZpYBPxxxQiWwVSYA+p5CWyucHK7M9BXyHChY35awaXcSVRNDDzCgtg8/abpUYCl0vE
         bNpuFKkzZhGOKqGu/PolYHkdCL+TreOHcrzKBz6xrrlhNk0c4a/P/fl7daV3+3RyDaKU
         lpCgi5Cp5evW2aZ2Yi/mFzHN/pBVzTj5jbE53I3rxlHcAvQv+2G1OOuGsMhItZgvi7S5
         Wu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738718514; x=1739323314;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WAelabJsFDQCp6OSdU0Y7aOri7VRZ4IciM6Wd7w26sc=;
        b=mbDLhzrOcGjI+mA6ZVsNT0h4lGT/4YdUyFvvXvytm4jHQVZjPJ5Cx335yTJhl3UzuJ
         jRUXLFmm6+eEYMTSQ5bXMo8sVPXz7zul5wAi2uXsTjKisXg68tc8OKXp7iSSW9yvx1RN
         439aoxb81aarBpiSf352ucRIr/78OhKtZRLcbLYi4LHEmnz/fuaMqKyMX9eiEQEzQnKv
         NAcXuUItHsLPY7yWfk+8xiWn9XLaZaHgpytQSzO0piX6SlR9nTLmxDZ47SzdVeOYshWH
         VyWH+TD8H16+5y0546eaYAFcFxpBE7FHxcW4tz4/DFE21W73WCVX3tJqOe1qyPejkXTq
         0hFA==
X-Forwarded-Encrypted: i=1; AJvYcCWoFXCRE5QAlWLTP54ZMme7ITmucIOAx8hpL2aSjkB+mObScbiT1Fs32iQ8EJtzIntkxJcivsy9Bp2bVgwv@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt/rgpV0Ayzh1gatm/DerAtZ4DtJTMPoUwVGl6fcZ6D58i6V+f
	U5fw4EkX+D73Q84NZFy1VWvSqbtqGzfgDo/zjtWP/XbaNRQSq71Yle9HxSBkCHs=
X-Gm-Gg: ASbGnctyC94inPijnJ8yAd3y/jPi5eIaD8pI/Zm/3wINxBqAlRs9Z+0mbBYiuhWFFdX
	OfvgnZAcJmtKpSxjE2E6q3uUY4gjTzmSsMXU7NUZtJ/MqA2/ZY0+kC45JQ42TsE2ynZ4+OyjRrT
	SUxOIYf/X0Eh1O/2j3dnkGAAl6/vDRTSGl9wYaRoJA7lAPPA/B6PWGBvn834aMFaiclbPOrDutP
	PG4awudb4REqM22zsBzxM7RFTY2jER+Rf3nEKOp7fWJXUi8NtAFjP6K6HjIEabjeYBXr91j5uBm
	5I/btBRb8LJRw9/okIduKG/Feg==
X-Google-Smtp-Source: AGHT+IE6Zkv813EgT0ESIaLEJg8jiQ4i2X0N7JUMSMiP3/aeLMnGI8u130cHLCiPsZbC78qiLiwi+w==
X-Received: by 2002:a05:6a00:ad1:b0:726:64a5:5f67 with SMTP id d2e1a72fcca58-73035135003mr1488946b3a.12.1738718513349;
        Tue, 04 Feb 2025 17:21:53 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69cec0fsm11457202b3a.137.2025.02.04.17.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 17:21:52 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v9 00/26] riscv control-flow integrity for usermode
Date: Tue, 04 Feb 2025 17:21:47 -0800
Message-Id: <20250204-v5_user_cfi_series-v9-0-b37a49c5205c@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACu9omcC/23OwW7DIAwG4FepOI/J4AKhp75HVUUJMasPSyrYU
 Ksq7z6aHVZN+PZb+j/7ITIlpiwOu4dIVDjzMtfg33YiXIb5gyRPNQsNeg8eQRbTf9dOHyL3v12
 JU0DUsYtm1KIWr4ki3zb0dK75wvlrSfftRlHP7cYpANXiipIgcRysGS0ZA/GYuCyZ5/Aelk/xF
 It9VbqmYqtiYfKRwGFE11Dci6J9U3FV0U67QN6jDWND6f6UOk2lq8oUSO2HAUHD/1/Wdf0BTzS
 pkokBAAA=
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
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, Deepak Gupta <debug@rivosinc.com>, 
 Andy Chiu <andybnac@gmail.com>
X-Mailer: b4 0.14.0

Basics and overview
===================

Software with larger attack surfaces (e.g. network facing apps like databases,
browsers or apps relying on browser runtimes) suffer from memory corruption
issues which can be utilized by attackers to bend control flow of the program
to eventually gain control (by making their payload executable). Attackers are
able to perform such attacks by leveraging call-sites which rely on indirect
calls or return sites which rely on obtaining return address from stack memory.

To mitigate such attacks, risc-v extension zicfilp enforces that all indirect
calls must land on a landing pad instruction `lpad` else cpu will raise software
check exception (a new cpu exception cause code on riscv).
Similarly for return flow, risc-v extension zicfiss extends architecture with

- `sspush` instruction to push return address on a shadow stack
- `sspopchk` instruction to pop return address from shadow stack
  and compare with input operand (i.e. return address on stack)
- `sspopchk` to raise software check exception if comparision above
  was a mismatch
- Protection mechanism using which shadow stack is not writeable via
  regular store instructions

More information an details can be found at extensions github repo [1].

Equivalent to landing pad (zicfilp) on x86 is `ENDBRANCH` instruction in Intel
CET [3] and branch target identification (BTI) [4] on arm.
Similarly x86's Intel CET has shadow stack [5] and arm64 has guarded control
stack (GCS) [6] which are very similar to risc-v's zicfiss shadow stack.

x86 and arm64 support for user mode shadow stack is already in mainline.

Kernel awareness for user control flow integrity
================================================

This series picks up Samuel Holland's envcfg changes [2] as well. So if those are
being applied independently, they should be removed from this series.

Enabling:

In order to maintain compatibility and not break anything in user mode, kernel
doesn't enable control flow integrity cpu extensions on binary by default.
Instead exposes a prctl interface to enable, disable and lock the shadow stack
or landing pad feature for a task. This allows userspace (loader) to enumerate
if all objects in its address space are compiled with shadow stack and landing
pad support and accordingly enable the feature. Additionally if a subsequent
`dlopen` happens on a library, user mode can take a decision again to disable
the feature (if incoming library is not compiled with support) OR terminate the
task (if user mode policy is strict to have all objects in address space to be
compiled with control flow integirty cpu feature). prctl to enable shadow stack
results in allocating shadow stack from virtual memory and activating for user
address space. x86 and arm64 are also following same direction due to similar
reason(s).

clone/fork:

On clone and fork, cfi state for task is inherited by child. Shadow stack is
part of virtual memory and is a writeable memory from kernel perspective
(writeable via a restricted set of instructions aka shadow stack instructions)
Thus kernel changes ensure that this memory is converted into read-only when
fork/clone happens and COWed when fault is taken due to sspush, sspopchk or
ssamoswap. In case `CLONE_VM` is specified and shadow stack is to be enabled,
kernel will automatically allocate a shadow stack for that clone call.

map_shadow_stack:

x86 introduced `map_shadow_stack` system call to allow user space to explicitly
map shadow stack memory in its address space. It is useful to allocate shadow
for different contexts managed by a single thread (green threads or contexts)
risc-v implements this system call as well.

signal management:

If shadow stack is enabled for a task, kernel performs an asynchronous control
flow diversion to deliver the signal and eventually expects userspace to issue
sigreturn so that original execution can be resumed. Even though resume context
is prepared by kernel, it is in user space memory and is subject to memory
corruption and corruption bugs can be utilized by attacker in this race window
to perform arbitrary sigreturn and eventually bypass cfi mechanism.
Another issue is how to ensure that cfi related state on sigcontext area is not
trampled by legacy apps or apps compiled with old kernel headers.

In order to mitigate control-flow hijacting, kernel prepares a token and place
it on shadow stack before signal delivery and places address of token in
sigcontext structure. During sigreturn, kernel obtains address of token from
sigcontext struture, reads token from shadow stack and validates it and only
then allow sigreturn to succeed. Compatiblity issue is solved by adopting
dynamic sigcontext management introduced for vector extension. This series
re-factor the code little bit to allow future sigcontext management easy (as
proposed by Andy Chiu from SiFive)

config and compilation:

Introduce a new risc-v config option `CONFIG_RISCV_USER_CFI`. Selecting this
config option picks the kernel support for user control flow integrity. This
optin is presented only if toolchain has shadow stack and landing pad support.
And is on purpose guarded by toolchain support. Reason being that eventually
vDSO also needs to be compiled in with shadow stack and landing pad support.
vDSO compile patches are not included as of now because landing pad labeling
scheme is yet to settle for usermode runtime.

To get more information on kernel interactions with respect to
zicfilp and zicfiss, patch series adds documentation for
`zicfilp` and `zicfiss` in following:
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
Get the lastest qemu
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

In case you're building your own rootfs using toolchain, please make sure you
pick following patch to ensure that vDSO compiled with lpad and shadow stack.

"arch/riscv: compile vdso with landing pad"

Branch where above patch can be picked
https://github.com/deepak0414/linux-riscv-cfi/tree/vdso_user_cfi_v6.12-rc1

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

References
==========
[1] - https://github.com/riscv/riscv-cfi
[2] - https://lore.kernel.org/all/20240814081126.956287-1-samuel.holland@sifive.com/
[3] - https://lwn.net/Articles/889475/
[4] - https://developer.arm.com/documentation/109576/0100/Branch-Target-Identification
[5] - https://www.intel.com/content/dam/develop/external/us/en/documents/catc17-introduction-intel-cet-844137.pdf
[6] - https://lwn.net/Articles/940403/

---
changelog
---------
v9:
- rebased on master (39a803b754d5 fix braino in "9p: fix ->rename_sem exclusion")
- dropped "mm: Introduce ARCH_HAS_USER_SHADOW_STACK" (master has it from arm64/gcs)
- dropped "prctl: arch-agnostic prctl for shadow stack" (master has it from arm64/gcs)

v8:
- rebased on palmer/for-next
- dropped samuel holland's `envcfg` context switch patches.
  they are in parlmer/for-next
  
v7:
- Removed "riscv/Kconfig: enable HAVE_EXIT_THREAD for riscv"
  Instead using `deactivate_mm` flow to clean up.
  see here for more context
  https://lore.kernel.org/all/20230908203655.543765-1-rick.p.edgecombe@intel.com/#t
- Changed the header include in `kselftest`. Hopefully this fixes compile
  issue faced by Zong Li at SiFive.
- Cleaned up an orphaned change to `mm/mmap.c` in below patch
  "riscv/mm : ensure PROT_WRITE leads to VM_READ | VM_WRITE"
- Lock interfaces for shadow stack and indirect branch tracking expect arg == 0
  Any future evolution of this interface should accordingly define how arg should
  be setup.
- `mm/map.c` has an instance of using `VM_SHADOW_STACK`. Fixed it to use helper
  `is_shadow_stack_vma`.
- Link to v6: https://lore.kernel.org/r/20241008-v5_user_cfi_series-v6-0-60d9fe073f37@rivosinc.com

v6:
- Picked up Samuel Holland's changes as is with `envcfg` placed in
  `thread` instead of `thread_info`
- fixed unaligned newline escapes in kselftest
- cleaned up messages in kselftest and included test output in commit message
- fixed a bug in clone path reported by Zong Li
- fixed a build issue if CONFIG_RISCV_ISA_V is not selected
  (this was introduced due to re-factoring signal context
  management code)

v5:
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
  FWFT
  (https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/src/ext-firmware-features.adoc)
- Link to v5: https://lore.kernel.org/r/20241001-v5_user_cfi_series-v1-0-3ba65b6e550f@rivosinc.com
  (Note: I had an issue in my workflow due to which version number wasn't
  picked up correctly while sending out patches)

v4:
- rebased on 6.11-rc6
- envcfg: Converged with Samuel Holland's patches for envcfg management on per-
thread basis.
- vma_is_shadow_stack is renamed to is_vma_shadow_stack
- picked up Mark Brown's `ARCH_HAS_USER_SHADOW_STACK` patch
- signal context: using extended context management to maintain compatibility.
- fixed `-Wmissing-prototypes` compiler warnings for prctl functions
- Documentation fixes and amending typos.
- Link to v4: https://lore.kernel.org/all/20240912231650.3740732-1-debug@rivosinc.com/

v3:
- envcfg
  logic to pick up base envcfg had a bug where `ENVCFG_CBZE` could have been
  picked on per task basis, even though CPU didn't implement it. Fixed in
   this series.

- dt-bindings
  As suggested, split into separate commit. fixed the messaging that spec is
  in public review

- arch_is_shadow_stack change
  arch_is_shadow_stack changed to vma_is_shadow_stack

- hwprobe
  zicfiss / zicfilp if present will get enumerated in hwprobe

- selftests
  As suggested, added object and binary filenames to .gitignore
  Selftest binary anyways need to be compiled with cfi enabled compiler which
  will make sure that landing pad and shadow stack are enabled. Thus removed
  separate enable/disable tests. Cleaned up tests a bit.

- Link to v3: https://lore.kernel.org/lkml/20240403234054.2020347-1-debug@rivosinc.com/

v2:
- Using config `CONFIG_RISCV_USER_CFI`, kernel support for riscv control flow
  integrity for user mode programs can be compiled in the kernel.

- Enabling of control flow integrity for user programs is left to user runtime

- This patch series introduces arch agnostic `prctls` to enable shadow stack
  and indirect branch tracking. And implements them on riscv.

---
Changes in v9:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v8: https://lore.kernel.org/r/20241111-v5_user_cfi_series-v8-0-dce14aa30207@rivosinc.com

Changes in v8:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v7: https://lore.kernel.org/r/20241029-v5_user_cfi_series-v7-0-2727ce9936cb@rivosinc.com

---
Andy Chiu (1):
      riscv: signal: abstract header saving for setup_sigcontext

Clément Léger (1):
      riscv: Add Firmware Feature SBI extensions definitions

Deepak Gupta (24):
      mm: helper `is_shadow_stack_vma` to check shadow stack vma
      dt-bindings: riscv: zicfilp and zicfiss in dt-bindings (extensions.yaml)
      riscv: zicfiss / zicfilp enumeration
      riscv: zicfiss / zicfilp extension csr and bit definitions
      riscv: usercfi state for task and save/restore of CSR_SSP on trap entry/exit
      riscv/mm : ensure PROT_WRITE leads to VM_READ | VM_WRITE
      riscv mm: manufacture shadow stack pte
      riscv mmu: teach pte_mkwrite to manufacture shadow stack PTEs
      riscv mmu: write protect and shadow stack
      riscv/mm: Implement map_shadow_stack() syscall
      riscv/shstk: If needed allocate a new shadow stack on clone
      riscv: Implements arch agnostic shadow stack prctls
      prctl: arch-agnostic prctl for indirect branch tracking
      riscv/traps: Introduce software check exception
      riscv/signal: save and restore of shadow stack for signal
      riscv/kernel: update __show_regs to print shadow stack register
      riscv/ptrace: riscv cfi status and state via ptrace and in core files
      riscv/hwprobe: zicfilp / zicfiss enumeration in hwprobe
      riscv: enable kernel access to shadow stack memory via FWFT sbi call
      riscv: kernel command line option to opt out of user cfi
      riscv: create a config for shadow stack and landing pad instr support
      riscv: Documentation for landing pad / indirect branch tracking
      riscv: Documentation for shadow stack on riscv
      kselftest/riscv: kselftest for user mode cfi

 Documentation/arch/riscv/index.rst                 |   2 +
 Documentation/arch/riscv/zicfilp.rst               | 115 +++++
 Documentation/arch/riscv/zicfiss.rst               | 176 +++++++
 .../devicetree/bindings/riscv/extensions.yaml      |  14 +
 arch/riscv/Kconfig                                 |  20 +
 arch/riscv/include/asm/asm-prototypes.h            |   1 +
 arch/riscv/include/asm/cpufeature.h                |  13 +
 arch/riscv/include/asm/csr.h                       |  16 +
 arch/riscv/include/asm/entry-common.h              |   2 +
 arch/riscv/include/asm/hwcap.h                     |   2 +
 arch/riscv/include/asm/mman.h                      |  25 +
 arch/riscv/include/asm/mmu_context.h               |   7 +
 arch/riscv/include/asm/pgtable.h                   |  30 +-
 arch/riscv/include/asm/processor.h                 |   2 +
 arch/riscv/include/asm/sbi.h                       |  26 +
 arch/riscv/include/asm/thread_info.h               |   3 +
 arch/riscv/include/asm/usercfi.h                   |  89 ++++
 arch/riscv/include/asm/vector.h                    |   3 +
 arch/riscv/include/uapi/asm/hwprobe.h              |   2 +
 arch/riscv/include/uapi/asm/ptrace.h               |  22 +
 arch/riscv/include/uapi/asm/sigcontext.h           |   1 +
 arch/riscv/kernel/Makefile                         |   1 +
 arch/riscv/kernel/asm-offsets.c                    |   8 +
 arch/riscv/kernel/cpufeature.c                     |   2 +
 arch/riscv/kernel/entry.S                          |  31 +-
 arch/riscv/kernel/head.S                           |  12 +
 arch/riscv/kernel/process.c                        |  26 +-
 arch/riscv/kernel/ptrace.c                         |  83 ++++
 arch/riscv/kernel/signal.c                         | 142 +++++-
 arch/riscv/kernel/sys_hwprobe.c                    |   2 +
 arch/riscv/kernel/sys_riscv.c                      |  10 +
 arch/riscv/kernel/traps.c                          |  43 ++
 arch/riscv/kernel/usercfi.c                        | 524 +++++++++++++++++++++
 arch/riscv/mm/init.c                               |   2 +-
 arch/riscv/mm/pgtable.c                            |  17 +
 include/linux/cpu.h                                |   4 +
 include/uapi/linux/elf.h                           |   1 +
 include/uapi/linux/prctl.h                         |  27 ++
 kernel/sys.c                                       |  30 ++
 mm/gup.c                                           |   2 +-
 mm/mmap.c                                          |   2 +-
 mm/vma.h                                           |  10 +-
 tools/testing/selftests/riscv/Makefile             |   2 +-
 tools/testing/selftests/riscv/cfi/.gitignore       |   3 +
 tools/testing/selftests/riscv/cfi/Makefile         |  10 +
 tools/testing/selftests/riscv/cfi/cfi_rv_test.h    |  84 ++++
 tools/testing/selftests/riscv/cfi/riscv_cfi_test.c |  78 +++
 tools/testing/selftests/riscv/cfi/shadowstack.c    | 375 +++++++++++++++
 tools/testing/selftests/riscv/cfi/shadowstack.h    |  37 ++
 49 files changed, 2106 insertions(+), 33 deletions(-)
---
base-commit: 39a803b754d5224a3522016b564113ee1e4091b2
change-id: 20240930-v5_user_cfi_series-3dc332f8f5b2
--
- debug


