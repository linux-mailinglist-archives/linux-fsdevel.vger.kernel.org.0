Return-Path: <linux-fsdevel+bounces-65342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDE6C02878
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 18:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFA951AA76D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 16:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAECA3431FC;
	Thu, 23 Oct 2025 16:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTjq+D3e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28BE33C529;
	Thu, 23 Oct 2025 16:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761238270; cv=none; b=OwBofG/ZHUX+LvLEMj2h2wxw/B+6yl+BmNghFdbySXgp589LUDvkbFRdiT2gthocJvDrnaXxMjCQqV+5dBvkcINgPNeci8KWbLpRUAJJJxGi/hg60lh/CQjJdRbOj2gqP81c/u169dS47cPBK21ZowFOqwyEivyAiyxDUNeMnbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761238270; c=relaxed/simple;
	bh=nXRmvGO3C/bPrlIIFA9iRn92TekqyVP5R5eclk8Sozo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=C8T7XO9s27cO0Qy7mv7DmrV5MiDkmsQzo8Qw43MzQdpv3PIWyrMyEntZ7/ArlBP/Xzp6wBA+GCA79bHxTk/QQQf5yY2iBYXWB4xlymp3X2HgfrBa6R+iAumA+xx9vSnJKxihAZMDKbCZFN/Awihr+OWzmtw3TlS26Lj3bEGlKiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTjq+D3e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79934C4CEFD;
	Thu, 23 Oct 2025 16:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761238269;
	bh=nXRmvGO3C/bPrlIIFA9iRn92TekqyVP5R5eclk8Sozo=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=hTjq+D3ey+cwOeKuyptOjhg9V40O56+NFIFVS08lBa1RMQ6cCSZJxuP7cPMFhS1oG
	 p7/XxXYpsdVjR7+5wtJ6YEggn6bLf29kc3BPZKWPZfxGbuRW5jB/2I5zQmVBvcPY/h
	 OlPKRSiXVhw4lncX8seG2KQKTKaymxXSWierdMLk500zXbDdu0MbWmHUX/LDWMBDz0
	 rjPXjL9UpIviVyABsTnSFhG0Jpu3ZyaPX8n8TllDjlFgrVbkIudzxdBDB9vcYgaZmq
	 CB3tQYrFezujLe+FbZ3tyybet9HbFbmbfBzmFv3wt3qRTILaRCkvTS359SVjnT11Vo
	 tqNXIPSI0p3YA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B99DCCD193;
	Thu, 23 Oct 2025 16:51:09 +0000 (UTC)
From: Deepak Gupta via B4 Relay <devnull+debug.rivosinc.com@kernel.org>
Subject: [PATCH v22 00/28] riscv control-flow integrity for usermode
Date: Thu, 23 Oct 2025 09:51:05 -0700
Message-Id: <20251023-v5_user_cfi_series-v22-0-1935270f7636@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPlc+mgC/3XTzY7UMAwH8FdZ9UyRPxIn4cR7IDRK0oTtgZlVB
 yrQat4ddxBqJdzeUiW/uvY/78O9LXO7D59e3oelrfN9vl11QfThZaiv+fqtjfOkLwYCcpAYxtV
 ffuqhS+3z5e/hkafKTD12X2jQg29L6/Ovp/rlq65f5/uP2/L7+ZEVt7dPDgHQ4lYcYeSSxRdp3
 kP/vMzr7T5f68d6+z5s4ipHJZqKqCIwpd4gcOdgKOGgUDKVoAoFCrWlxFKLocRd0cdUoipTbeh
 yZiCwakn/FK8bnKkkVQqH7FL1BL4aCsKBQbDbC+qg6NR6ZqwCloO7w2fONqcoZWtLLwlNh46O/
 VtI6jSPuql4Ro6Ww7vj6MRhdVJAx2FqPkq2HHd07JFrmTB64qSpmADJdPzuaKdtx2/1oEsiLmC
 M3nLk4NCJ80yy64KZfWvNSg+G3ZGT+OCWZefFV6o9SrLuFcbdCSdhxi3NObYm1FPn2CznEOfAJ
 86WZ0jFSZxCadm6W7TnGUEHbDm05bmkqbmilxTJqofw6Hjb2fIsGUL00hL81+fH4/EHOy3icjA
 FAAA=
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
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org, 
 Zong Li <zong.li@sifive.com>, David Hildenbrand <david@redhat.com>, 
 Deepak Gupta <debug@rivosinc.com>, Charles Mirabile <cmirabil@redhat.com>, 
 Andy Chiu <andybnac@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761238267; l=27700;
 i=debug@rivosinc.com; s=20251023; h=from:subject:message-id;
 bh=nXRmvGO3C/bPrlIIFA9iRn92TekqyVP5R5eclk8Sozo=;
 b=51tI8a+8qdclpLuXm9WB8KjVyNQHJ3f1amYAhiew0DpabHcSh5P+2a0Dr4Ky8vAPRSK+DeFkB
 lyIJM/DjmcaBFlM9+PWqEr3qr8wYX9rKBQeK8yuOrSpvkKRi36IOyfY
X-Developer-Key: i=debug@rivosinc.com; a=ed25519;
 pk=O37GQv1thBhZToXyQKdecPDhtWVbEDRQ0RIndijvpjk=
X-Endpoint-Received: by B4 Relay for debug@rivosinc.com/20251023 with
 auth_id=553
X-Original-From: Deepak Gupta <debug@rivosinc.com>
Reply-To: debug@rivosinc.com

v22: fixing build error due to -march=zicfiss being picked in gcc-13 and above
but not actually doing any codegen or recognizing instruction for zicfiss.
Change in v22 makes dependence on `-fcf-protection=full` compiler flag to
ensure that toolchain has support and then only CONFIG_RISCV_USER_CFI will be
visible in menuconfig.

v21: fixed build errors.

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

Running
-------

Modify your qemu command to have:
-bios <path-to-cfi-opensbi>/build/platform/generic/firmware/fw_dynamic.bin
-cpu rv64,zicfilp=true,zicfiss=true,zimop=true,zcmop=true

References
==========
[1] - https://github.com/riscv/riscv-cfi
[2] - https://lore.kernel.org/all/20240814081126.956287-1-samuel.holland@sifive.com/
[3] - https://lwn.net/Articles/889475/
[4] - https://developer.arm.com/documentation/109576/0100/Branch-Target-Identification
[5] - https://www.intel.com/content/dam/develop/external/us/en/documents/catc17-introduction-intel-cet-844137.pdf
[6] - https://lwn.net/Articles/940403/

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
To: Jann Horn <jannh@google.com>
To: Conor Dooley <conor+dt@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>
To: Alex Gaynor <alex.gaynor@gmail.com>
To: Boqun Feng <boqun.feng@gmail.com>
To: Gary Guo <gary@garyguo.net>
To: Björn Roy Baron <bjorn3_gh@protonmail.com>
To: Benno Lossin <benno.lossin@proton.me>
To: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
To: Trevor Gross <tmgross@umich.edu>
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
Cc: rust-for-linux@vger.kernel.org

changelog
---------
v22:
- CONFIG_RISCV_USER_CFI was by default "n". With dual vdso support it is
  default "y" (if toolchain supports it). Fixing build error due to
  "-march=zicfiss" being picked in gcc-13 partially. gcc-13 only recognizes the
  flag but not actually doing any codegen or recognizing instruction for zicfiss.
  Change in v22 makes dependence on `-fcf-protection=full` compiler flag to
  ensure that toolchain has support and then only CONFIG_RISCV_USER_CFI will be
  visible in menuconfig.
- picked up tags and some cosmetic changes in commit message for dual vdso
  patch.
  

v21:
- Fixing build errors due to changes in arch/riscv/include/asm/vdso.h
  Using #ifdef instead of IS_ENABLED in arch/riscv/include/asm/vdso.h
  vdso-cfi-offsets.h should be included only when CONFIG_RISCV_USER_CFI
  is selected.

v20:
- rebased on v6.18-rc1.
- Added two vDSO support. If `CONFIG_RISCV_USER_CFI` is selected
  two vDSOs are compiled (one for hardware prior to RVA23 and one
  for RVA23 onwards). Kernel exposes RVA23 vDSO if hardware/cpu
  implements zimop else exposes existing vDSO to userspace.
- default selection for `CONFIG_RISCV_USER_CFI` is "Yes".
- replaced "__ASSEMBLY__" with "__ASSEMBLER__"

v19:
- riscv_nousercfi was `int`. changed it to unsigned long.
  Thanks to Alex Ghiti for reporting it. It was a bug.
- ELP is cleared on trap entry only when CONFIG_64BIT.
- restore ssp back on return to usermode was being done
  before `riscv_v_context_nesting_end` on trap exit path.
  If kernel shadow stack were enabled this would result in
  kernel operating on user shadow stack and panic (as I found
  in my testing of kcfi patch series). So fixed that.

v18:
- rebased on 6.16-rc1
- uprobe handling clears ELP in sstatus image in pt_regs
- vdso was missing shadow stack elf note for object files.
  added that. Additional asm file for vdso needed the elf marker
  flag. toolchain should complain if `-fcf-protection=full` and
  marker is missing for object generated from asm file. Asked
  toolchain folks to fix this. Although no reason to gate the merge
  on that.
- Split up compile options for march and fcf-protection in vdso
  Makefile
- CONFIG_RISCV_USER_CFI option is moved under "Kernel features" menu
  Added `arch/riscv/configs/hardening.config` fragment which selects
  CONFIG_RISCV_USER_CFI

v17:
- fixed warnings due to empty macros in usercfi.h (reported by alexg)
- fixed prefixes in commit titles reported by alexg
- took below uprobe with fcfi v2 patch from Zong Li and squashed it with
  "riscv/traps: Introduce software check exception and uprobe handling"
  https://lore.kernel.org/all/20250604093403.10916-1-zong.li@sifive.com/

v16:
- If FWFT is not implemented or returns error for shadow stack activation, then
  no_usercfi is set to disable shadow stack. Although this should be picked up
  by extension validation and activation. Fixed this bug for zicfilp and zicfiss
  both. Thanks to Charlie Jenkins for reporting this.
- If toolchain doesn't support cfi, cfi kselftest shouldn't build. Suggested by
  Charlie Jenkins.
- Default for CONFIG_RISCV_USER_CFI is set to no. Charlie/Atish suggested to
  keep it off till we have more hardware availibility with RVA23 profile and
  zimop/zcmop implemented. Else this will start breaking people's workflow
- Includes the fix if "!RV64 and !SBI" then definitions for FWFT in
  asm-offsets.c error.

v15:
- Toolchain has been updated to include `-fcf-protection` flag. This
  exists for x86 as well. Updated kernel patches to compile vDSO and
  selftest to compile with `fcf-protection=full` flag.
- selecting CONFIG_RISCV_USERCFI selects CONFIG_RISCV_SBI.
- Patch to enable shadow stack for kernel wasn't hidden behind
  CONFIG_RISCV_USERCFI and CONFIG_RISCV_SBI. fixed that.

v14:
- rebased on top of palmer/sbi-v3. Thus dropped clement's FWFT patches
  Updated RISCV_ISA_EXT_XXXX in hwcap and hwprobe constants.
- Took Radim's suggestions on bitfields.
- Placed cfi_state at the end of thread_info block so that current situation
  is not disturbed with respect to member fields of thread_info in single
  cacheline.

v13:
- cpu_supports_shadow_stack/cpu_supports_indirect_br_lp_instr uses
  riscv_has_extension_unlikely()
- uses nops(count) to create nop slide
- RISCV_ACQUIRE_BARRIER is not needed in `amo_user_shstk`. Removed it
- changed ternaries to simply use implicit casting to convert to bool.
- kernel command line allows to disable zicfilp and zicfiss independently.
  updated kernel-parameters.txt.
- ptrace user abi for cfi uses bitmasks instead of bitfields. Added ptrace
  kselftest.
- cosmetic and grammatical changes to documentation.

v12:
- It seems like I had accidently squashed arch agnostic indirect branch
  tracking prctl and riscv implementation of those prctls. Split them again.
- set_shstk_status/set_indir_lp_status perform CSR writes only when CPU
  support is available. As suggested by Zong Li.
- Some minor clean up in kselftests as suggested by Zong Li.

v11:
- patch "arch/riscv: compile vdso with landing pad" was unconditionally
  selecting `_zicfilp` for vDSO compile. fixed that. Changed `lpad 1` to
  to `lpad 0`. 
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
Changes in v22:
- Link to v21: https://lore.kernel.org/r/20251015-v5_user_cfi_series-v21-0-6a07856e90e7@rivosinc.com

Changes in v21:
- Link to v20: https://lore.kernel.org/r/20251013-v5_user_cfi_series-v20-0-b9de4be9912e@rivosinc.com

Changes in v20:
- Link to v19: https://lore.kernel.org/r/20250731-v5_user_cfi_series-v19-0-09b468d7beab@rivosinc.com

Changes in v19:
- Link to v18: https://lore.kernel.org/r/20250711-v5_user_cfi_series-v18-0-a8ee62f9f38e@rivosinc.com

Changes in v18:
- Link to v17: https://lore.kernel.org/r/20250604-v5_user_cfi_series-v17-0-4565c2cf869f@rivosinc.com

Changes in v17:
- Link to v16: https://lore.kernel.org/r/20250522-v5_user_cfi_series-v16-0-64f61a35eee7@rivosinc.com

Changes in v16:
- Link to v15: https://lore.kernel.org/r/20250502-v5_user_cfi_series-v15-0-914966471885@rivosinc.com

Changes in v15:
- changelog posted just below cover letter
- Link to v14: https://lore.kernel.org/r/20250429-v5_user_cfi_series-v14-0-5239410d012a@rivosinc.com

Changes in v14:

- changelog posted just below cover letter
- Link to v13: https://lore.kernel.org/r/20250424-v5_user_cfi_series-v13-0-971437de586a@rivosinc.com

Changes in v13:
- changelog posted just below cover letter
- Link to v12: https://lore.kernel.org/r/20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com

Changes in v12:
- changelog posted just below cover letter
- Link to v11: https://lore.kernel.org/r/20250310-v5_user_cfi_series-v11-0-86b36cbfb910@rivosinc.com

Changes in v11:
- changelog posted just below cover letter
- Link to v10: https://lore.kernel.org/r/20250210-v5_user_cfi_series-v10-0-163dcfa31c60@rivosinc.com

---
Andy Chiu (1):
      riscv: signal: abstract header saving for setup_sigcontext

Deepak Gupta (26):
      mm: VM_SHADOW_STACK definition for riscv
      dt-bindings: riscv: zicfilp and zicfiss in dt-bindings (extensions.yaml)
      riscv: zicfiss / zicfilp enumeration
      riscv: zicfiss / zicfilp extension csr and bit definitions
      riscv: usercfi state for task and save/restore of CSR_SSP on trap entry/exit
      riscv/mm : ensure PROT_WRITE leads to VM_READ | VM_WRITE
      riscv/mm: manufacture shadow stack pte
      riscv/mm: teach pte_mkwrite to manufacture shadow stack PTEs
      riscv/mm: write protect and shadow stack
      riscv/mm: Implement map_shadow_stack() syscall
      riscv/shstk: If needed allocate a new shadow stack on clone
      riscv: Implements arch agnostic shadow stack prctls
      prctl: arch-agnostic prctl for indirect branch tracking
      riscv: Implements arch agnostic indirect branch tracking prctls
      riscv/traps: Introduce software check exception and uprobe handling
      riscv/signal: save and restore of shadow stack for signal
      riscv/kernel: update __show_regs to print shadow stack register
      riscv/ptrace: riscv cfi status and state via ptrace and in core files
      riscv/hwprobe: zicfilp / zicfiss enumeration in hwprobe
      riscv: kernel command line option to opt out of user cfi
      riscv: enable kernel access to shadow stack memory via FWFT sbi call
      arch/riscv: dual vdso creation logic and select vdso based on hw
      riscv: create a config for shadow stack and landing pad instr support
      riscv: Documentation for landing pad / indirect branch tracking
      riscv: Documentation for shadow stack on riscv
      kselftest/riscv: kselftest for user mode cfi

Jim Shu (1):
      arch/riscv: compile vdso with landing pad and shadow stack note

 Documentation/admin-guide/kernel-parameters.txt    |   8 +
 Documentation/arch/riscv/index.rst                 |   2 +
 Documentation/arch/riscv/zicfilp.rst               | 115 +++++
 Documentation/arch/riscv/zicfiss.rst               | 179 +++++++
 .../devicetree/bindings/riscv/extensions.yaml      |  14 +
 arch/riscv/Kconfig                                 |  22 +
 arch/riscv/Makefile                                |   8 +-
 arch/riscv/configs/hardening.config                |   4 +
 arch/riscv/include/asm/asm-prototypes.h            |   1 +
 arch/riscv/include/asm/assembler.h                 |  44 ++
 arch/riscv/include/asm/cpufeature.h                |  12 +
 arch/riscv/include/asm/csr.h                       |  16 +
 arch/riscv/include/asm/entry-common.h              |   2 +
 arch/riscv/include/asm/hwcap.h                     |   2 +
 arch/riscv/include/asm/mman.h                      |  26 +
 arch/riscv/include/asm/mmu_context.h               |   7 +
 arch/riscv/include/asm/pgtable.h                   |  30 +-
 arch/riscv/include/asm/processor.h                 |   1 +
 arch/riscv/include/asm/thread_info.h               |   3 +
 arch/riscv/include/asm/usercfi.h                   |  95 ++++
 arch/riscv/include/asm/vdso.h                      |  13 +-
 arch/riscv/include/asm/vector.h                    |   3 +
 arch/riscv/include/uapi/asm/hwprobe.h              |   2 +
 arch/riscv/include/uapi/asm/ptrace.h               |  34 ++
 arch/riscv/include/uapi/asm/sigcontext.h           |   1 +
 arch/riscv/kernel/Makefile                         |   2 +
 arch/riscv/kernel/asm-offsets.c                    |  10 +
 arch/riscv/kernel/cpufeature.c                     |  27 +
 arch/riscv/kernel/entry.S                          |  38 ++
 arch/riscv/kernel/head.S                           |  27 +
 arch/riscv/kernel/process.c                        |  27 +-
 arch/riscv/kernel/ptrace.c                         |  95 ++++
 arch/riscv/kernel/signal.c                         | 148 +++++-
 arch/riscv/kernel/sys_hwprobe.c                    |   2 +
 arch/riscv/kernel/sys_riscv.c                      |  10 +
 arch/riscv/kernel/traps.c                          |  54 ++
 arch/riscv/kernel/usercfi.c                        | 545 +++++++++++++++++++++
 arch/riscv/kernel/vdso.c                           |   7 +
 arch/riscv/kernel/vdso/Makefile                    |  40 +-
 arch/riscv/kernel/vdso/flush_icache.S              |   4 +
 arch/riscv/kernel/vdso/gen_vdso_offsets.sh         |   4 +-
 arch/riscv/kernel/vdso/getcpu.S                    |   4 +
 arch/riscv/kernel/vdso/note.S                      |   3 +
 arch/riscv/kernel/vdso/rt_sigreturn.S              |   4 +
 arch/riscv/kernel/vdso/sys_hwprobe.S               |   4 +
 arch/riscv/kernel/vdso/vgetrandom-chacha.S         |   5 +-
 arch/riscv/kernel/vdso_cfi/Makefile                |  25 +
 arch/riscv/kernel/vdso_cfi/vdso-cfi.S              |  11 +
 arch/riscv/mm/init.c                               |   2 +-
 arch/riscv/mm/pgtable.c                            |  16 +
 include/linux/cpu.h                                |   4 +
 include/linux/mm.h                                 |   7 +
 include/uapi/linux/elf.h                           |   2 +
 include/uapi/linux/prctl.h                         |  27 +
 kernel/sys.c                                       |  30 ++
 tools/testing/selftests/riscv/Makefile             |   2 +-
 tools/testing/selftests/riscv/cfi/.gitignore       |   3 +
 tools/testing/selftests/riscv/cfi/Makefile         |  16 +
 tools/testing/selftests/riscv/cfi/cfi_rv_test.h    |  82 ++++
 tools/testing/selftests/riscv/cfi/riscv_cfi_test.c | 173 +++++++
 tools/testing/selftests/riscv/cfi/shadowstack.c    | 385 +++++++++++++++
 tools/testing/selftests/riscv/cfi/shadowstack.h    |  27 +
 62 files changed, 2475 insertions(+), 41 deletions(-)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20240930-v5_user_cfi_series-3dc332f8f5b2
--
- debug



