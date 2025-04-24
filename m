Return-Path: <linux-fsdevel+bounces-47174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F1FA9A32D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 09:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36239447F9D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 07:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402D41EA7DD;
	Thu, 24 Apr 2025 07:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Afzk/yDi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429AD1DB13E
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 07:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745479225; cv=none; b=OM2tbR06U4ayDAbV9HfPlqivibB+CgAapZ+nnx2Srg+E0fZHZPP+L2d/OftHCO2YCCQW5pb4h7Zx487HhUKcMgMuCZbc/jUlIHosqvj0e1kFBLwbKIVMfJp3bc8PsiITVJL88b+0lOLpNfNe0Tg05shQ8oGjbx/QlKI/zenBYGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745479225; c=relaxed/simple;
	bh=pgkfR95kN5OzaJawcLOAQZYkniiOp828cOw5FJ9oAWs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WsDC7hMv8DsgciVa38+UX6YHmbrjTKbuI2teUI66RB9B8p5dBU8mSwIKDKSmPv/6x+Uf90YfpOUUFa0OpLDTDXwfAFd9IooD60MlTH8THpAB2xBNo/+UgOMTvWSI0pMztLUbSvYcE4rLFLDYT8zIlbsCGhcSDJhj8pe9T2oARHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Afzk/yDi; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-224019ad9edso8996425ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 00:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745479221; x=1746084021; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=usKnIUb1cxEdCgV1e6ENtzi+t578JQxV0u8DozWSzyg=;
        b=Afzk/yDiZjwXtjYf3rKbgQd+dkXOOaalxcO+wVy1qxy6LcM2gMQmabtH6nOM4/AIDE
         JbnvjaKWAATHG9TKpe97YJowCYqOflkUYEKoQ7AS8oglxErdz7AHdqEZblENoyLa2EIp
         qeOetsGA7F9lzD/djodje9NMsv1x0xgY4E7ECZpcd4tLW1Z4olwnhn8tZCywE19rawvI
         5qcdANer51PRFAVb8fzjqRhRjCTXtgCLKYTcTUhJ2leCeAIatwoLJ4WJTg+2KAUKm2cP
         IL/QZY8sA5Kk6eLKwEtXomUBS1WX5VeDeQPnymDlTWNPE8wdAvMv5RRu3iJXIVaukqUc
         9ZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745479221; x=1746084021;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=usKnIUb1cxEdCgV1e6ENtzi+t578JQxV0u8DozWSzyg=;
        b=R0JiLK2/RWFAbP5mPRgYoO0hO3eaF5myF6NBO4KpThg9RUmLeN520eFwMmRrnGMDFC
         mLMCLWNVsYTg6mGAwOz6sTpGKLh8wEIRB7CAXtRKlMD3efPRwvGJC8YnzvKlj9xFZXsI
         q8oa7rKUjY3FnNcmq9t2FEon75ABJAaFoqpFvwQxXvQfiGps66+vH2K9+hpUM4p1Lwmn
         2UsnyvLw//eBt5oWA9I2YJ7+0jWGC4rR6EWmeZMa1aWVoE1scr/b82cG4mXuEWYFTkEn
         XsgON9cYxnKccNu4FI3BXLZmOivV+pyHDbGv2JwiBrMvfVUmvJMdaOwNFmxbx8TZDDd8
         9ETg==
X-Forwarded-Encrypted: i=1; AJvYcCVehUftxwo7FPeQbk+xyWncqW42d8upvswPQgtlBpcbIwOsk7ZpaWklPvCxMw5/zu3uHtuHFTfvZR12LCbt@vger.kernel.org
X-Gm-Message-State: AOJu0YykFldrn8aqnEmjpmyQmdjEG5nQz53pSlENCkpeuoI4R4qCaJHr
	EgeQnW3NibbWfjV3/vu0KQzc8NFd1GyXbEurBbQPkbNWODYDYnwCxgkXySRxCB0=
X-Gm-Gg: ASbGncs3unl1JHBH4hP15Gl05wx4wx/qcYZX4a3ibUo+sUa6F3hHbpfzNgywVAkE8yh
	myH85Vq01sVBqn6o4PTVeoPL6gwzTGBvg1yE1BfBQLQ265eV0R7X/Pgdr12/wlQe8UWiEnnTn0T
	F9DZrsI7G0QtHsQafrIyG/pl/zaW/wPwpGJqaahTOuXj+YJtpQFcIKVY03mfJKTS/HWxhWj5uqu
	qOncJ47mEzhhon+GPJJ2cue7Us5R7FA0bbwu9wtkHf6xJuBclixKGJWhf2Ssvzps+Zdh4GTbwGJ
	8Yj+FKjxMwQY01ax5kIiE1lcm1PEJhjUrnYgC43MRXE8J9O+s90=
X-Google-Smtp-Source: AGHT+IFfQh51tWX7HuEUdEYzO/DzFuTRLidmlmaeweeMhM2+r2SPa9yQegdM4EPcZtNrBt/r0B6ZDg==
X-Received: by 2002:a17:902:d489:b0:220:ff3f:6cba with SMTP id d9443c01a7336-22db3d71b30mr24027515ad.38.1745479221324;
        Thu, 24 Apr 2025 00:20:21 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db52163d6sm6240765ad.214.2025.04.24.00.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 00:20:20 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v13 00/28] riscv control-flow integrity for usermode
Date: Thu, 24 Apr 2025 00:20:15 -0700
Message-Id: <20250424-v5_user_cfi_series-v13-0-971437de586a@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAC/mCWgC/3XRUU/EIAwA4L9y4dmZlg4YPvk/jFmAgceDN7Ppo
 rnsv9vNmFtM5a1N+wHtVc15qnlWD6ermvJS5zpeOEC6O6l0DpeX3NSBE0qDbsETNIvpP7ipT6X
 2P80NDYlIl66YqBU3vk251M9dfXrm+Fzn93H62i9ZcMvuHAKgxC3YQEMxWBNtNgbK41SXca6Xd
 J/GV7WJiz0qnahYViwMvmRwVMgJijso2ouKY0U77VL2nmyKgtLdFD6i0rEypIxtCAQapLf4X8V
 wQSsqnpVILrQ+GQ0mCQrCgUGQxwvsoOWtlUCYLEgO3hz6z9n21Nm4jaVEj6Kjj478LdTsZINcF
 A0hdX+cdV2/AZIaVUWoAgAA
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
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org, 
 Zong Li <zong.li@sifive.com>, Deepak Gupta <debug@rivosinc.com>, 
 Andy Chiu <andybnac@gmail.com>
X-Mailer: b4 0.13.0

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

Clément Léger (1):
      riscv: Add Firmware Feature SBI extensions definitions

Deepak Gupta (25):
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
      riscv: Implements arch agnostic indirect branch tracking prctls
      riscv/traps: Introduce software check exception
      riscv/signal: save and restore of shadow stack for signal
      riscv/kernel: update __show_regs to print shadow stack register
      riscv/ptrace: riscv cfi status and state via ptrace and in core files
      riscv/hwprobe: zicfilp / zicfiss enumeration in hwprobe
      riscv: kernel command line option to opt out of user cfi
      riscv: enable kernel access to shadow stack memory via FWFT sbi call
      riscv: create a config for shadow stack and landing pad instr support
      riscv: Documentation for landing pad / indirect branch tracking
      riscv: Documentation for shadow stack on riscv
      kselftest/riscv: kselftest for user mode cfi

Jim Shu (1):
      arch/riscv: compile vdso with landing pad

 Documentation/admin-guide/kernel-parameters.txt    |   8 +
 Documentation/arch/riscv/index.rst                 |   2 +
 Documentation/arch/riscv/zicfilp.rst               | 115 +++++
 Documentation/arch/riscv/zicfiss.rst               | 179 +++++++
 .../devicetree/bindings/riscv/extensions.yaml      |  14 +
 arch/riscv/Kconfig                                 |  20 +
 arch/riscv/Makefile                                |   5 +-
 arch/riscv/include/asm/asm-prototypes.h            |   1 +
 arch/riscv/include/asm/assembler.h                 |  44 ++
 arch/riscv/include/asm/cpufeature.h                |  12 +
 arch/riscv/include/asm/csr.h                       |  16 +
 arch/riscv/include/asm/entry-common.h              |   2 +
 arch/riscv/include/asm/hwcap.h                     |   2 +
 arch/riscv/include/asm/mman.h                      |  25 +
 arch/riscv/include/asm/mmu_context.h               |   7 +
 arch/riscv/include/asm/pgtable.h                   |  30 +-
 arch/riscv/include/asm/processor.h                 |   2 +
 arch/riscv/include/asm/sbi.h                       |  26 +
 arch/riscv/include/asm/thread_info.h               |   3 +
 arch/riscv/include/asm/usercfi.h                   |  96 ++++
 arch/riscv/include/asm/vector.h                    |   3 +
 arch/riscv/include/uapi/asm/hwprobe.h              |   2 +
 arch/riscv/include/uapi/asm/ptrace.h               |  34 ++
 arch/riscv/include/uapi/asm/sigcontext.h           |   1 +
 arch/riscv/kernel/Makefile                         |   1 +
 arch/riscv/kernel/asm-offsets.c                    |   8 +
 arch/riscv/kernel/cpufeature.c                     |  13 +
 arch/riscv/kernel/entry.S                          |  28 +-
 arch/riscv/kernel/head.S                           |  23 +
 arch/riscv/kernel/process.c                        |  26 +-
 arch/riscv/kernel/ptrace.c                         |  95 ++++
 arch/riscv/kernel/signal.c                         | 142 +++++-
 arch/riscv/kernel/sys_hwprobe.c                    |   2 +
 arch/riscv/kernel/sys_riscv.c                      |  10 +
 arch/riscv/kernel/traps.c                          |  43 ++
 arch/riscv/kernel/usercfi.c                        | 545 +++++++++++++++++++++
 arch/riscv/kernel/vdso/Makefile                    |   6 +
 arch/riscv/kernel/vdso/flush_icache.S              |   4 +
 arch/riscv/kernel/vdso/getcpu.S                    |   4 +
 arch/riscv/kernel/vdso/rt_sigreturn.S              |   4 +
 arch/riscv/kernel/vdso/sys_hwprobe.S               |   4 +
 arch/riscv/mm/init.c                               |   2 +-
 arch/riscv/mm/pgtable.c                            |  17 +
 include/linux/cpu.h                                |   4 +
 include/linux/mm.h                                 |   7 +
 include/uapi/linux/elf.h                           |   1 +
 include/uapi/linux/prctl.h                         |  27 +
 kernel/sys.c                                       |  30 ++
 tools/testing/selftests/riscv/Makefile             |   2 +-
 tools/testing/selftests/riscv/cfi/.gitignore       |   3 +
 tools/testing/selftests/riscv/cfi/Makefile         |  10 +
 tools/testing/selftests/riscv/cfi/cfi_rv_test.h    |  82 ++++
 tools/testing/selftests/riscv/cfi/riscv_cfi_test.c | 171 +++++++
 tools/testing/selftests/riscv/cfi/shadowstack.c    | 385 +++++++++++++++
 tools/testing/selftests/riscv/cfi/shadowstack.h    |  27 +
 55 files changed, 2346 insertions(+), 29 deletions(-)
---
base-commit: 39a803b754d5224a3522016b564113ee1e4091b2
change-id: 20240930-v5_user_cfi_series-3dc332f8f5b2
--
- debug


