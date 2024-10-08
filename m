Return-Path: <linux-fsdevel+bounces-31369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD380995A26
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 00:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30AED1F24666
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 22:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FB1216426;
	Tue,  8 Oct 2024 22:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="P1CFfmai"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5384184551
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Oct 2024 22:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728427070; cv=none; b=LJC7c9ag9gitql/NaTzkD3VGzWkAHmW7cfM2EgcbTPUv67V8bbnb5EkF9RKjNTt6Ik4pf3ltj7O5rwb5Zsb0M7ZrpRd5HIcCdWrgi2u0+eUxbqTvW5uA558M2A2Ec+UUWPGWLyWUwDNHhOxp0nT4eyrF8bMU5i3fGFmRQ+YVFB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728427070; c=relaxed/simple;
	bh=PHZLxjRz6XVFbQRoCI8Phc+LGhYVjl839/p/w/o2QKw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pFVwGdD2A8azBn8o6HUt/ffy7N6O7kRCHCRWeTcsTr8SBF0Un3L55rvm63eByrQ2VM/t/zvnmrFSrDRmBvKGL/gzJqfj8Y1JNxdSlVqr2gu6uWQPml5tB+i5nldfbwdXJW1b13sPk4Q6OdTtmiVDgIokS/qYcA9CxbDWuPUVKiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=P1CFfmai; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ea0ae67df5so2166526a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Oct 2024 15:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728427067; x=1729031867; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YT6jBbRZ8hZ5+d5YKC7Sze5MFu5F8/gSPRiKDGliAGQ=;
        b=P1CFfmairgb8OQpLvuovhZXmh9srw4kT15eN7Ac/F7qHJe/cUsNyTM+uac0Bi+mMRM
         R69/Z1NvYlAPN2yF9Yq19i5HaedLB5fu9NPK2vzMHoxyo9jfP1J2UMHx73hVePMmhPUT
         JYoEq3/zjSMEMznUg3NwF8y8gjkS5eHeTpUzLb89gkZZnELDi+23Oerm9kzbpJfGwjBZ
         25ViZmG7Ie986kLjdM18C/PtVDtS7W/5ZglAquK1wu3dKz5BraaCNiNgv7tCZB0RfJC7
         9VieBQkvpmP/mXkLNwdQiMAW2dPyOBj3WepLpJ6uao1tvxGMUR62DwX/bku3pDHY+wvi
         a/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728427067; x=1729031867;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YT6jBbRZ8hZ5+d5YKC7Sze5MFu5F8/gSPRiKDGliAGQ=;
        b=HLF9YwADfKdzg1Ygp1okLdmOS7rYOkp9g2DfeZ5RR5KqU0NFK8FZHS5fbqRdBKn7uS
         IMO0qHSVYqXMgWkK9CTQ9I8659uE6elRFIgj4BMtQ7mvTFb0/RAzwbu/HlcwV2WjOwZ5
         ABY4CnXAWFgQBXx2KEaKhL81ZHmWsCPcIdTFMJEl5Fc5TYLHpMcqJ0aIbWpvQ38ZsDL3
         uHyvp3G0WQUx6Q8x3jEzmdCtkHC4gC00jUpOEAMGbwyWL0KaPIJ/Tdpxd+RYZ2M98IWF
         BDg42ZnFhLrZA9xmbTS0OTHW7YEA7XG6NOPmKigYqg2uAd0yebPNH7b29vK5cw8C0eco
         7h8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXhwz2YyyZytKQA0H7Qybe9WT8rBuAPllldkywh8pz9/hixZq8MgvHl8kisE8qewN/+yJMU1R48X9YI4pZ2@vger.kernel.org
X-Gm-Message-State: AOJu0YxEUQP9d9WO1l7IzrACC1wjZjE1slnuC3RUSRlZL7w0HNWEK5tL
	ocPYuYKqoy1F6e/uXiTE7O8B7lvOcvA0eUQFIbHgKkOkoU8ATI3LN9QqeBXB4yv0HvouwJ4NwfQ
	V
X-Google-Smtp-Source: AGHT+IHoy0X8xSg8yluDnHlNMiuIhfODa4MLaXY5veheVmh0OO+3syJQ+aerSJIHUmm6Sml2D5IVfA==
X-Received: by 2002:a05:6a20:9f03:b0:1d8:a247:945d with SMTP id adf61e73a8af0-1d8a3c5c4famr587986637.50.1728427066964;
        Tue, 08 Oct 2024 15:37:46 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0ccc4b2sm6591270b3a.45.2024.10.08.15.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 15:37:46 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v6 00/33] riscv control-flow integrity for usermode
Date: Tue, 08 Oct 2024 15:36:42 -0700
Message-Id: <20241008-v5_user_cfi_series-v6-0-60d9fe073f37@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPuzBWcC/22NwQ7CIBAFf6XZs5gFhKgn/8M0pFCwe7A0oETT8
 O9ivXqcl8y8FbJP5DOcuxWSL5Qpzg30rgM3DfPNMxobg0BxwJNEVpR5Nse4QObnMjk6KUU4BmU
 FNHFJPtBri177xhPlR0zv7aPw77rlOCL/lyucIZN20MpqrxSGS6ISM81u7+Id+lrrB3OP87W3A
 AAA
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

x86 already supports shadow stack for user mode and arm64 support for GCS in
usermode [7] is ongoing.

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

Branch where user cfi enabling patches are maintained
https://github.com/deepak0414/linux-riscv-cfi/tree/vdso_user_cfi_v6.12-rc1

In case you're building your own rootfs using toolchain, please make sure you
pick following patch to ensure that vDSO compiled with lpad and shadow stack.

"arch/riscv: compile vdso with landing pad"

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
[7] - https://lore.kernel.org/all/20241001-arm64-gcs-v13-0-222b78d87eee@kernel.org/

To: Thomas Gleixner <tglx@linutronix.de>
To: Ingo Molnar <mingo@redhat.com>
To: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@linux.intel.com>
To: x86@kernel.org
To: H. Peter Anvin <hpa@zytor.com>
To: Andrew Morton <akpm@linux-foundation.org>
To: Liam R. Howlett <Liam.Howlett@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Paul Walmsley <paul.walmsley@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
To: Albert Ou <aou@eecs.berkeley.edu>
To: Conor Dooley <conor@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
To: Christian Brauner <brauner@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
To: Eric Biederman <ebiederm@xmission.com>
To: Kees Cook <kees@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-riscv@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: alistair.francis@wdc.com
Cc: richard.henderson@linaro.org
Cc: jim.shu@sifive.com
Cc: andybnac@gmail.com
Cc: kito.cheng@sifive.com
Cc: charlie@rivosinc.com
Cc: atishp@rivosinc.com
Cc: evan@rivosinc.com
Cc: cleger@rivosinc.com
Cc: alexghiti@rivosinc.com
Cc: samitolvanen@google.com
Cc: broonie@kernel.org
Cc: rick.p.edgecombe@intel.com

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
changelog
---------

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
Andy Chiu (1):
      riscv: signal: abstract header saving for setup_sigcontext

Clément Léger (1):
      riscv: Add Firmware Feature SBI extensions definitions

Deepak Gupta (26):
      mm: helper `is_shadow_stack_vma` to check shadow stack vma
      riscv/Kconfig: enable HAVE_EXIT_THREAD for riscv
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
      prctl: arch-agnostic prctl for indirect branch tracking
      riscv: Implements arch agnostic shadow stack prctls
      riscv: Implements arch agnostic indirect branch tracking prctls
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
 arch/riscv/Kconfig                                 |  21 +
 arch/riscv/include/asm/asm-prototypes.h            |   1 +
 arch/riscv/include/asm/cpufeature.h                |  15 +-
 arch/riscv/include/asm/csr.h                       |  16 +
 arch/riscv/include/asm/entry-common.h              |   2 +
 arch/riscv/include/asm/hwcap.h                     |   2 +
 arch/riscv/include/asm/mman.h                      |  24 +
 arch/riscv/include/asm/pgtable.h                   |  30 +-
 arch/riscv/include/asm/processor.h                 |   3 +
 arch/riscv/include/asm/sbi.h                       |  27 ++
 arch/riscv/include/asm/switch_to.h                 |   8 +
 arch/riscv/include/asm/thread_info.h               |   3 +
 arch/riscv/include/asm/usercfi.h                   |  89 ++++
 arch/riscv/include/asm/vector.h                    |   3 +
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
 tools/testing/selftests/riscv/cfi/cfi_rv_test.h    |  84 ++++
 tools/testing/selftests/riscv/cfi/riscv_cfi_test.c |  78 +++
 tools/testing/selftests/riscv/cfi/shadowstack.c    | 373 +++++++++++++++
 tools/testing/selftests/riscv/cfi/shadowstack.h    |  37 ++
 56 files changed, 2190 insertions(+), 42 deletions(-)
---
base-commit: 7d9923ee3960bdbfaa7f3a4e0ac2364e770c46ff
change-id: 20240930-v5_user_cfi_series-3dc332f8f5b2
--
- debug


