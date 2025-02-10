Return-Path: <linux-fsdevel+bounces-41451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF9BA2FA04
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 21:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 986977A2AEC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 20:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF2D2505B8;
	Mon, 10 Feb 2025 20:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="3DvpPjYE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAAA24E4DC
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 20:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739219206; cv=none; b=jvUaZiIG662fZt32gKdYshu3tJolOAaDZy0ZvTj0T6dM27ht4i6nGIu5LSOXXKh/NxGoK96W1layifZUVtbiD7NIUle6LmDxlxB7fImN3CncBU2ufN71wC5NPLKbWb5BKLIhpsxqIEx71dWK+D/XEheT5slqKc6eugyrMIt/wnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739219206; c=relaxed/simple;
	bh=lpSpxynGrl82OulloSqzXf28G+Bq/im403WTALruyi4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WBu1v5s7idzLu/Ge3Isw36K0h6sWjkJL4CWEwQkkT9nLGR+5cTu9VFNgbGaOW+FE+FkgHKfhG/q/Tp99G9ACqBY3mslQVuJFUE6/NCciVtYvi+36uQuV10Op72eDuTOJPV7/zAzdk25y2DO+7aWT2jzbxxPCO942/fLck1Fo0ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=3DvpPjYE; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21f464b9a27so79489515ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 12:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739219202; x=1739824002; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fUFsKc+z24eVk8hplfaO8I9DnaR0/8yv8+Omgp/axfY=;
        b=3DvpPjYEcykMX4266Xelhwj9yAzI3kC/+vYTVzMk/PREfSYs6COawgJxixKo8QZJ8Y
         lAuxVg25rA1z+/rOVG/hJ35WtXttr7R5dGrGXbbsfruJpetHzOzXhj0VH1o1tDTDopLL
         A38LK0Q4rNqMfzp8COkRLldjSPmXQb4v3knjzcf0dpESxqoEeZOZOYXZt9/d99E9GSc5
         yv2woOYEU/iVPcI+nDYOYG0n4XJ3HcXxeFCoHT3O83eyMorgqu8+ZMon4DoJvdakBhH3
         8h+L53+J3jVpEvn20Og1uIUHytUbCYHIY4IczZ3BeD5dtFJQ2/mxpXnVn+z9uVa3XQQB
         0j0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739219202; x=1739824002;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fUFsKc+z24eVk8hplfaO8I9DnaR0/8yv8+Omgp/axfY=;
        b=a67Nme76OmmW8JhXQVjASCjjfSi7TAwCKS5hTZDKR3FNhXYuHohcX6JWEbmnBx2tS3
         MWVEq+ANch4sjw4v0lt/iIk4wMWj5wsTzz58pImg5MtWL4UNK7dDpnVpGv8QTTP6CF0+
         l8O2ll0fYEwruJkfxBzsL6dqMqpHZpsCM0MP0pAXnBuzbvY94MTTYNidvjXfzyAgpoMd
         STyCo2pAruA9IH8ogxpN5M4LVRvNeEWiMwx2gZ97NxhyzL3nsA4J7dKF2R0WXCuf90gJ
         PBLB9ICZmPZNhvJMupWDliKikcOKExRG2RDnaaq7ZlTBUigu+tlr3+gOTJJNgGpuDH4T
         IJTw==
X-Forwarded-Encrypted: i=1; AJvYcCU63900SLbYaj/e8AO9jNVmQYHpJfWS/p05rPRDZlJmywz0IsRTH0So1CyS7VjPKaJYhOdxMiyz44twcGXq@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1LH4L3WIrQybU0jYLWOjtZXNXhR27pNd4nZDbJFY/bMGBGkJX
	ZNSHqk7+r5lrXPSE9TJdMspAjWnPibxQ6bQTgyeaPuvUmSUTYfjGkBdZQ26BQnJgEgIZJLBtE/F
	U
X-Gm-Gg: ASbGnct+Tz/gGNmh6GbRVuLurwS1wgqNyaluDOTC9akAqzm96VV7zXOiy5TH/Bt6bhm
	TeYXuP6u5Ltx8Z5d+COtRn3mmoFA6lZxS0qjNAUCaTarUstY0uW1Svgl9UjpAhf9viLx0pxA2SL
	aSKoXJfA0LaI4fuFNaR9Eyv7X3NyUQ6RPkDCXNGAJuJ7cJdUTKet8jPqiGJ6/lGCvfvPbtTfNdb
	r0i4ToNIkLDI2CW62pr6PHpilQPD9c9YHg5GQHSy5DQrE7cIGQpmkOB3X73mn5Amcsi9W1BxrSz
	N8o+SC9t8bQlpWJchkbtsVr8pA==
X-Google-Smtp-Source: AGHT+IH06oSIqnkdabnxufYD1jWMlLt99FVKlNnV1jo7QqydG6jz5rMWO6L4ZRvKWTSieO3E83veMQ==
X-Received: by 2002:a17:902:ce0e:b0:216:325f:6f2b with SMTP id d9443c01a7336-21f4e6afe61mr260848125ad.21.1739219201583;
        Mon, 10 Feb 2025 12:26:41 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3687c187sm83711555ad.168.2025.02.10.12.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 12:26:41 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v10 00/27] riscv control-flow integrity for usermode
Date: Mon, 10 Feb 2025 12:26:33 -0800
Message-Id: <20250210-v5_user_cfi_series-v10-0-163dcfa31c60@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPlgqmcC/23OwU4EIQwG4FfZcBZT6ACDJ9/DmAl0wOXgjBmUa
 Dbz7nbHGDeG3tr0/9qLqGkrqYqH00VsqZVa1oUbBXcnQeewvCRZZh4IDXoAjyCbmT44NFEu009
 Y4kyIOo/ZRC04+LalXD4P9emZ+3Op7+v2dRxp6jo9OAWgelxTEiTGYE20yRjIj1tpay0L3dP6K
 q5is7fK2FUsKxZmnxM4zOg6irtRtO8qjhXttKPkPVqKHWX8U7i6ysjKTEkNISBo6P3ifxXDC0N
 X8axEdGHwZDQY+qfs+/4NYXCc0NABAAA=
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
v10:
- dropped "mm: helper `is_shadow_stack_vma` to check shadow stack vma". This patch
  is not that interesting to this patch series for risc-v. There are instances in
  arch directories where VM_SHADOW_STACK flag is anyways used. Dropping this patch
  to expedite merging in riscv tree.
- Took suggestions from `Clement` on "riscv: zicfiss / zicfilp enumeration" to
  validate presence of cfi based on config.
- Added a patch for vDSO to have `lpad 0`. I had omitted this earlier to make sure
  we add single vdso object with cfi enabled. But a vdso object with scheme of 
  zero labeled landing pad is least common denominator and should work with all
  objects of zero labeled as well as function-signature labeled objects.

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

---
Andy Chiu (1):
      riscv: signal: abstract header saving for setup_sigcontext

Clément Léger (1):
      riscv: Add Firmware Feature SBI extensions definitions

Deepak Gupta (24):
      mm: VM_SHADOW_STACK definition for riscv
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

Jim Shu (1):
      arch/riscv: compile vdso with landing pad

 Documentation/arch/riscv/index.rst                 |   2 +
 Documentation/arch/riscv/zicfilp.rst               | 115 +++++
 Documentation/arch/riscv/zicfiss.rst               | 176 +++++++
 .../devicetree/bindings/riscv/extensions.yaml      |  14 +
 arch/riscv/Kconfig                                 |  20 +
 arch/riscv/Makefile                                |   7 +-
 arch/riscv/include/asm/asm-prototypes.h            |   1 +
 arch/riscv/include/asm/assembler.h                 |  44 ++
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
 arch/riscv/kernel/cpufeature.c                     |  13 +
 arch/riscv/kernel/entry.S                          |  31 +-
 arch/riscv/kernel/head.S                           |  12 +
 arch/riscv/kernel/process.c                        |  26 +-
 arch/riscv/kernel/ptrace.c                         |  83 ++++
 arch/riscv/kernel/signal.c                         | 142 +++++-
 arch/riscv/kernel/sys_hwprobe.c                    |   2 +
 arch/riscv/kernel/sys_riscv.c                      |  10 +
 arch/riscv/kernel/traps.c                          |  43 ++
 arch/riscv/kernel/usercfi.c                        | 524 +++++++++++++++++++++
 arch/riscv/kernel/vdso/Makefile                    |   8 +
 arch/riscv/kernel/vdso/flush_icache.S              |   4 +
 arch/riscv/kernel/vdso/getcpu.S                    |   4 +
 arch/riscv/kernel/vdso/rt_sigreturn.S              |   4 +
 arch/riscv/kernel/vdso/sys_hwprobe.S               |   4 +
 arch/riscv/mm/init.c                               |   2 +-
 arch/riscv/mm/pgtable.c                            |  17 +
 include/linux/cpu.h                                |   4 +
 include/linux/mm.h                                 |   7 +
 include/uapi/linux/elf.h                           |   1 +
 include/uapi/linux/prctl.h                         |  27 ++
 kernel/sys.c                                       |  30 ++
 tools/testing/selftests/riscv/Makefile             |   2 +-
 tools/testing/selftests/riscv/cfi/.gitignore       |   3 +
 tools/testing/selftests/riscv/cfi/Makefile         |  10 +
 tools/testing/selftests/riscv/cfi/cfi_rv_test.h    |  84 ++++
 tools/testing/selftests/riscv/cfi/riscv_cfi_test.c |  78 +++
 tools/testing/selftests/riscv/cfi/shadowstack.c    | 375 +++++++++++++++
 tools/testing/selftests/riscv/cfi/shadowstack.h    |  37 ++
 54 files changed, 2189 insertions(+), 29 deletions(-)
---
base-commit: 39a803b754d5224a3522016b564113ee1e4091b2
change-id: 20240930-v5_user_cfi_series-3dc332f8f5b2
--
- debug


