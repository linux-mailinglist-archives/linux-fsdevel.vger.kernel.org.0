Return-Path: <linux-fsdevel+bounces-49738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFC8AC1C90
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 07:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1F017AC9EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 05:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868F3222584;
	Fri, 23 May 2025 05:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="gtdm3NSq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C7222170A
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 May 2025 05:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747978953; cv=none; b=tZ/RHGh3DisYgClf08UTSXd0ODdXMUTNoVheVLLwQOd+SbIeWzrqAflTnjtstwhGJwzzChAi2Pp7pKjhVm/bgYkIF1Cagb0bxqb7WsXWd6eUklsU9QtpmyHOnr5VFaTJQ3TLo9leG6Y2nK4q36jYhnlMiX1HPVjY4VVDBFjS6e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747978953; c=relaxed/simple;
	bh=iupuMVhDsJhh+5Y2OivvSHzFJRR6F5HCUC1/OBgDQuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2oZbwyyFspCk71WdXD6ObXHcRMtptowy1ROI8NV8JljhQu5/0VsGhqrlUmIRQ1tYn7cE0undBTbLfz8Kpn9pbeOacNbfOobEQkMbWcRNP5qB6lUgI9YSjGwqLt9jSmBXL5td6YXDs8U+SAxiQLoVx3YNueC8LaZ2w4EcCGdLtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=gtdm3NSq; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2322f8afe02so47237415ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 May 2025 22:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747978948; x=1748583748; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PeXlR6fyrmkHtIBcqOOOkDBJgHZzvF+dTABh5DbyJWU=;
        b=gtdm3NSqqxeUccJY0C4hn413bPS592ceL+UojajQZYVKSUkHH3l0gCsrddA42Agi5S
         VdgiXewYF7+mRvVr8OEYPx30qyO6UXHwoh7wUoOALrIID93Mr+z07uIeRjSK5+HywhRi
         bjz1rNFaoJG3qFGzq0AdQD1YLne4cPFl+z71gGv4Vhf2CBE2Bp5o4874lsF9ixfTnvu6
         RLtAFNFv4KawMPgdm//BweVwQRybzku/CIJyV+EpCQBrz6C0LYGQidjxWgNboYlCLMWQ
         PjeRJ43x1wnATeyKqR6Aj/R+1rFHGL3vSygjGRKAA33+1VR+wDI4OJj5phJ0Jgvb1I8w
         5qWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747978948; x=1748583748;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PeXlR6fyrmkHtIBcqOOOkDBJgHZzvF+dTABh5DbyJWU=;
        b=CLS8vu34rwvd038PM1oU4Nv0bXoRzWuKlxvXm1TH0NIAHQmOcQa56SRn/ZS47OS6WU
         Y4J469YSRUbQplblZ94ReH1kvexLWLsdW6mUv0KcgjdsxnH1eTMPJ4nN2Pbted1ScCvd
         QhexLiPpyjTRbmImMeM8aYY9fNwrVBE/M3bhk365V4B0MYD8xvLuxvRFYB89yz5i2v26
         7OBILnzgjvMrnAmDVhQRuq4mircH1Ix+fVQYiamfag6xIF9Eh+YRlu1IHaAz3F+qOjYk
         KSHswMLuy7JLwoMHPnS/mXNX0098cNWYo+dm/mFwucr/eeGlTj7VEj3OIvVyWAQXvexy
         RCfw==
X-Forwarded-Encrypted: i=1; AJvYcCVuPU2eSrBOYYH1htLRNah0/PNFY1q1YM6aaN7Uwz34HQTP0Qq+el5p9uQSLORX0Os9DHglEO2KyLM1Oym3@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1udmGdwsJ2MW1R2ThbEQ5Yw140XEjNUlobATiJCrssyje4Cvl
	rKVUTqYsZM/BfBmv+5LIby4XiQ5G7iJI9UHhbYZCe4j3BXRcmcYyuHIUSFdzdgX/pAM=
X-Gm-Gg: ASbGncsv21iDc+j/xhqwXShoQRZrz/Daz2S+PW9TQBCil013j6btZwGL+62CHNqFto+
	OVM0QsLXKmqQOvHIJD5DZXlxqRmWJdtK+4yaMA9iB5HyL7QCcCewOy4XX+hcsdIGX+/LjaOuslW
	EKuI/Zwh5ZxaKHQuH/KjHH4K8S5YCgke9F2xiOBlO5sw5036ebi3wmgNcjujzgjm2y4uXkYxNfQ
	RZVOSjU33P2qxFZknSD8Ep6K1aD/tIGGPQRU0DmuHcGP3nxAStz3Ohf5BOLhe8ed6hmsm+mammw
	AKq5v9OWpshFMxFcEyARGlT8QhAXfgmBnxmqyH4ykTghuEiUZBa41zRMArLr4Q==
X-Google-Smtp-Source: AGHT+IGxcfKTCsiLmQRetPvmpC8gr+QZ1joNLj/c7syc1uVWDhku1OKydg/AXIRqLtvSi4z4WzZIWg==
X-Received: by 2002:a17:902:c951:b0:220:c4e8:3b9f with SMTP id d9443c01a7336-231d3536065mr372194685ad.0.1747978947701;
        Thu, 22 May 2025 22:42:27 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ac94a0sm117355075ad.2.2025.05.22.22.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 22:42:27 -0700 (PDT)
Date: Thu, 22 May 2025 22:42:22 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	alistair.francis@wdc.com, richard.henderson@linaro.org,
	jim.shu@sifive.com, andybnac@gmail.com, kito.cheng@sifive.com,
	charlie@rivosinc.com, atishp@rivosinc.com, evan@rivosinc.com,
	cleger@rivosinc.com, alexghiti@rivosinc.com,
	samitolvanen@google.com, broonie@kernel.org,
	rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org,
	Zong Li <zong.li@sifive.com>, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v16 00/27] riscv control-flow integrity for usermode
Message-ID: <aDAKvogbPValQGR-@debug.ba.rivosinc.com>
References: <20250522-v5_user_cfi_series-v16-0-64f61a35eee7@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250522-v5_user_cfi_series-v16-0-64f61a35eee7@rivosinc.com>

Alex,

Sorry for this last minute another revision. There was a bug (see changelog)
that charlie reported. Although that could have been sent as a later fixup.

Primary reason to send another revision is to flip default of
`CONFIG_RISCV_USER_CFI` to `N` from `Y`.After having discussion with Atish and
Charlie, we came to a conclusion that `CONFIG_RISCV_USER_CFI` should be by
default set to `N`. Reason being there are no RVA23 hardware today, although
toolchain already have `-march=zicfilp_zicfiss` options being support. This
would lead to cfi config being selected and generated vDSO would also have
shadow stack instructions in them. On a RVA23 compatible hardware (or any cpu
implementing zimop and zcmop) this shouldn't be a problem. But that's not the
case today, most hardware dont have these extension implemented. And thus it
would start leading to illegal instruction exception.

So either you can take this revision (it has your reported fix for
"riscv: enable kernel access to shadow stack memory via FWFT sbi call" where
kernel build was failing when !SBI and !RV64) or you can change default of
CONFIG_RISCV_USER_CFI to no (in patch "riscv: create a config for shadow stack
and landing pad instr support"). Let me know.


On Thu, May 22, 2025 at 10:31:03PM -0700, Deepak Gupta wrote:
>Basics and overview
>===================
>
>Software with larger attack surfaces (e.g. network facing apps like databases,
>browsers or apps relying on browser runtimes) suffer from memory corruption
>issues which can be utilized by attackers to bend control flow of the program
>to eventually gain control (by making their payload executable). Attackers are
>able to perform such attacks by leveraging call-sites which rely on indirect
>calls or return sites which rely on obtaining return address from stack memory.
>
>To mitigate such attacks, risc-v extension zicfilp enforces that all indirect
>calls must land on a landing pad instruction `lpad` else cpu will raise software
>check exception (a new cpu exception cause code on riscv).
>Similarly for return flow, risc-v extension zicfiss extends architecture with
>
>- `sspush` instruction to push return address on a shadow stack
>- `sspopchk` instruction to pop return address from shadow stack
>  and compare with input operand (i.e. return address on stack)
>- `sspopchk` to raise software check exception if comparision above
>  was a mismatch
>- Protection mechanism using which shadow stack is not writeable via
>  regular store instructions
>
>More information an details can be found at extensions github repo [1].
>
>Equivalent to landing pad (zicfilp) on x86 is `ENDBRANCH` instruction in Intel
>CET [3] and branch target identification (BTI) [4] on arm.
>Similarly x86's Intel CET has shadow stack [5] and arm64 has guarded control
>stack (GCS) [6] which are very similar to risc-v's zicfiss shadow stack.
>
>x86 and arm64 support for user mode shadow stack is already in mainline.
>
>Kernel awareness for user control flow integrity
>================================================
>
>This series picks up Samuel Holland's envcfg changes [2] as well. So if those are
>being applied independently, they should be removed from this series.
>
>Enabling:
>
>In order to maintain compatibility and not break anything in user mode, kernel
>doesn't enable control flow integrity cpu extensions on binary by default.
>Instead exposes a prctl interface to enable, disable and lock the shadow stack
>or landing pad feature for a task. This allows userspace (loader) to enumerate
>if all objects in its address space are compiled with shadow stack and landing
>pad support and accordingly enable the feature. Additionally if a subsequent
>`dlopen` happens on a library, user mode can take a decision again to disable
>the feature (if incoming library is not compiled with support) OR terminate the
>task (if user mode policy is strict to have all objects in address space to be
>compiled with control flow integirty cpu feature). prctl to enable shadow stack
>results in allocating shadow stack from virtual memory and activating for user
>address space. x86 and arm64 are also following same direction due to similar
>reason(s).
>
>clone/fork:
>
>On clone and fork, cfi state for task is inherited by child. Shadow stack is
>part of virtual memory and is a writeable memory from kernel perspective
>(writeable via a restricted set of instructions aka shadow stack instructions)
>Thus kernel changes ensure that this memory is converted into read-only when
>fork/clone happens and COWed when fault is taken due to sspush, sspopchk or
>ssamoswap. In case `CLONE_VM` is specified and shadow stack is to be enabled,
>kernel will automatically allocate a shadow stack for that clone call.
>
>map_shadow_stack:
>
>x86 introduced `map_shadow_stack` system call to allow user space to explicitly
>map shadow stack memory in its address space. It is useful to allocate shadow
>for different contexts managed by a single thread (green threads or contexts)
>risc-v implements this system call as well.
>
>signal management:
>
>If shadow stack is enabled for a task, kernel performs an asynchronous control
>flow diversion to deliver the signal and eventually expects userspace to issue
>sigreturn so that original execution can be resumed. Even though resume context
>is prepared by kernel, it is in user space memory and is subject to memory
>corruption and corruption bugs can be utilized by attacker in this race window
>to perform arbitrary sigreturn and eventually bypass cfi mechanism.
>Another issue is how to ensure that cfi related state on sigcontext area is not
>trampled by legacy apps or apps compiled with old kernel headers.
>
>In order to mitigate control-flow hijacting, kernel prepares a token and place
>it on shadow stack before signal delivery and places address of token in
>sigcontext structure. During sigreturn, kernel obtains address of token from
>sigcontext struture, reads token from shadow stack and validates it and only
>then allow sigreturn to succeed. Compatiblity issue is solved by adopting
>dynamic sigcontext management introduced for vector extension. This series
>re-factor the code little bit to allow future sigcontext management easy (as
>proposed by Andy Chiu from SiFive)
>
>config and compilation:
>
>Introduce a new risc-v config option `CONFIG_RISCV_USER_CFI`. Selecting this
>config option picks the kernel support for user control flow integrity. This
>optin is presented only if toolchain has shadow stack and landing pad support.
>And is on purpose guarded by toolchain support. Reason being that eventually
>vDSO also needs to be compiled in with shadow stack and landing pad support.
>vDSO compile patches are not included as of now because landing pad labeling
>scheme is yet to settle for usermode runtime.
>
>To get more information on kernel interactions with respect to
>zicfilp and zicfiss, patch series adds documentation for
>`zicfilp` and `zicfiss` in following:
>Documentation/arch/riscv/zicfiss.rst
>Documentation/arch/riscv/zicfilp.rst
>
>How to test this series
>=======================
>
>Toolchain
>---------
>$ git clone git@github.com:sifive/riscv-gnu-toolchain.git -b cfi-dev
>$ riscv-gnu-toolchain/configure --prefix=<path-to-where-to-build> --with-arch=rv64gc_zicfilp_zicfiss --enable-linux --disable-gdb  --with-extra-multilib-test="rv64gc_zicfilp_zicfiss-lp64d:-static"
>$ make -j$(nproc)
>
>Qemu
>----
>Get the lastest qemu
>$ cd qemu
>$ mkdir build
>$ cd build
>$ ../configure --target-list=riscv64-softmmu
>$ make -j$(nproc)
>
>Opensbi
>-------
>$ git clone git@github.com:deepak0414/opensbi.git -b v6_cfi_spec_split_opensbi
>$ make CROSS_COMPILE=<your riscv toolchain> -j$(nproc) PLATFORM=generic
>
>Linux
>-----
>Running defconfig is fine. CFI is enabled by default if the toolchain
>supports it.
>
>$ make ARCH=riscv CROSS_COMPILE=<path-to-cfi-riscv-gnu-toolchain>/build/bin/riscv64-unknown-linux-gnu- -j$(nproc) defconfig
>$ make ARCH=riscv CROSS_COMPILE=<path-to-cfi-riscv-gnu-toolchain>/build/bin/riscv64-unknown-linux-gnu- -j$(nproc)
>
>In case you're building your own rootfs using toolchain, please make sure you
>pick following patch to ensure that vDSO compiled with lpad and shadow stack.
>
>"arch/riscv: compile vdso with landing pad"
>
>Branch where above patch can be picked
>https://github.com/deepak0414/linux-riscv-cfi/tree/vdso_user_cfi_v6.12-rc1
>
>Running
>-------
>
>Modify your qemu command to have:
>-bios <path-to-cfi-opensbi>/build/platform/generic/firmware/fw_dynamic.bin
>-cpu rv64,zicfilp=true,zicfiss=true,zimop=true,zcmop=true
>
>vDSO related Opens (in the flux)
>=================================
>
>I am listing these opens for laying out plan and what to expect in future
>patch sets. And of course for the sake of discussion.
>
>Shadow stack and landing pad enabling in vDSO
>----------------------------------------------
>vDSO must have shadow stack and landing pad support compiled in for task
>to have shadow stack and landing pad support. This patch series doesn't
>enable that (yet). Enabling shadow stack support in vDSO should be
>straight forward (intend to do that in next versions of patch set). Enabling
>landing pad support in vDSO requires some collaboration with toolchain folks
>to follow a single label scheme for all object binaries. This is necessary to
>ensure that all indirect call-sites are setting correct label and target landing
>pads are decorated with same label scheme.
>
>How many vDSOs
>---------------
>Shadow stack instructions are carved out of zimop (may be operations) and if CPU
>doesn't implement zimop, they're illegal instructions. Kernel could be running on
>a CPU which may or may not implement zimop. And thus kernel will have to carry 2
>different vDSOs and expose the appropriate one depending on whether CPU implements
>zimop or not.
>
>References
>==========
>[1] - https://github.com/riscv/riscv-cfi
>[2] - https://lore.kernel.org/all/20240814081126.956287-1-samuel.holland@sifive.com/
>[3] - https://lwn.net/Articles/889475/
>[4] - https://developer.arm.com/documentation/109576/0100/Branch-Target-Identification
>[5] - https://www.intel.com/content/dam/develop/external/us/en/documents/catc17-introduction-intel-cet-844137.pdf
>[6] - https://lwn.net/Articles/940403/
>
>To: Thomas Gleixner <tglx@linutronix.de>
>To: Ingo Molnar <mingo@redhat.com>
>To: Borislav Petkov <bp@alien8.de>
>To: Dave Hansen <dave.hansen@linux.intel.com>
>To: x86@kernel.org
>To: H. Peter Anvin <hpa@zytor.com>
>To: Andrew Morton <akpm@linux-foundation.org>
>To: Liam R. Howlett <Liam.Howlett@oracle.com>
>To: Vlastimil Babka <vbabka@suse.cz>
>To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>To: Paul Walmsley <paul.walmsley@sifive.com>
>To: Palmer Dabbelt <palmer@dabbelt.com>
>To: Albert Ou <aou@eecs.berkeley.edu>
>To: Conor Dooley <conor@kernel.org>
>To: Rob Herring <robh@kernel.org>
>To: Krzysztof Kozlowski <krzk+dt@kernel.org>
>To: Arnd Bergmann <arnd@arndb.de>
>To: Christian Brauner <brauner@kernel.org>
>To: Peter Zijlstra <peterz@infradead.org>
>To: Oleg Nesterov <oleg@redhat.com>
>To: Eric Biederman <ebiederm@xmission.com>
>To: Kees Cook <kees@kernel.org>
>To: Jonathan Corbet <corbet@lwn.net>
>To: Shuah Khan <shuah@kernel.org>
>To: Jann Horn <jannh@google.com>
>To: Conor Dooley <conor+dt@kernel.org>
>To: Miguel Ojeda <ojeda@kernel.org>
>To: Alex Gaynor <alex.gaynor@gmail.com>
>To: Boqun Feng <boqun.feng@gmail.com>
>To: Gary Guo <gary@garyguo.net>
>To: Björn Roy Baron <bjorn3_gh@protonmail.com>
>To: Benno Lossin <benno.lossin@proton.me>
>To: Andreas Hindborg <a.hindborg@kernel.org>
>To: Alice Ryhl <aliceryhl@google.com>
>To: Trevor Gross <tmgross@umich.edu>
>Cc: linux-kernel@vger.kernel.org
>Cc: linux-fsdevel@vger.kernel.org
>Cc: linux-mm@kvack.org
>Cc: linux-riscv@lists.infradead.org
>Cc: devicetree@vger.kernel.org
>Cc: linux-arch@vger.kernel.org
>Cc: linux-doc@vger.kernel.org
>Cc: linux-kselftest@vger.kernel.org
>Cc: alistair.francis@wdc.com
>Cc: richard.henderson@linaro.org
>Cc: jim.shu@sifive.com
>Cc: andybnac@gmail.com
>Cc: kito.cheng@sifive.com
>Cc: charlie@rivosinc.com
>Cc: atishp@rivosinc.com
>Cc: evan@rivosinc.com
>Cc: cleger@rivosinc.com
>Cc: alexghiti@rivosinc.com
>Cc: samitolvanen@google.com
>Cc: broonie@kernel.org
>Cc: rick.p.edgecombe@intel.com
>Cc: rust-for-linux@vger.kernel.org
>
>changelog
>---------
>v16:
>- If FWFT is not implemented or returns error for shadow stack activation, then
>  no_usercfi is set to disable shadow stack. Although this should be picked up
>  by extension validation and activation. Fixed this bug for zicfilp and zicfiss
>  both. Thanks to Charlie Jenkins for reporting this.
>- If toolchain doesn't support cfi, cfi kselftest shouldn't build. Suggested by
>  Charlie Jenkins.
>- Default for CONFIG_RISCV_USER_CFI is set to no. Charlie/Atish suggested to
>  keep it off till we have more hardware availibility with RVA23 profile and
>  zimop/zcmop implemented. Else this will start breaking people's workflow
>- Includes the fix if "!RV64 and !SBI" then definitions for FWFT in
>  asm-offsets.c error.
>
>v15:
>- Toolchain has been updated to include `-fcf-protection` flag. This
>  exists for x86 as well. Updated kernel patches to compile vDSO and
>  selftest to compile with `fcf-protection=full` flag.
>- selecting CONFIG_RISCV_USERCFI selects CONFIG_RISCV_SBI.
>- Patch to enable shadow stack for kernel wasn't hidden behind
>  CONFIG_RISCV_USERCFI and CONFIG_RISCV_SBI. fixed that.
>
>v14:
>- rebased on top of palmer/sbi-v3. Thus dropped clement's FWFT patches
>  Updated RISCV_ISA_EXT_XXXX in hwcap and hwprobe constants.
>- Took Radim's suggestions on bitfields.
>- Placed cfi_state at the end of thread_info block so that current situation
>  is not disturbed with respect to member fields of thread_info in single
>  cacheline.
>
>v13:
>- cpu_supports_shadow_stack/cpu_supports_indirect_br_lp_instr uses
>  riscv_has_extension_unlikely()
>- uses nops(count) to create nop slide
>- RISCV_ACQUIRE_BARRIER is not needed in `amo_user_shstk`. Removed it
>- changed ternaries to simply use implicit casting to convert to bool.
>- kernel command line allows to disable zicfilp and zicfiss independently.
>  updated kernel-parameters.txt.
>- ptrace user abi for cfi uses bitmasks instead of bitfields. Added ptrace
>  kselftest.
>- cosmetic and grammatical changes to documentation.
>
>v12:
>- It seems like I had accidently squashed arch agnostic indirect branch
>  tracking prctl and riscv implementation of those prctls. Split them again.
>- set_shstk_status/set_indir_lp_status perform CSR writes only when CPU
>  support is available. As suggested by Zong Li.
>- Some minor clean up in kselftests as suggested by Zong Li.
>
>v11:
>- patch "arch/riscv: compile vdso with landing pad" was unconditionally
>  selecting `_zicfilp` for vDSO compile. fixed that. Changed `lpad 1` to
>  to `lpad 0`.
>v10:
>- dropped "mm: helper `is_shadow_stack_vma` to check shadow stack vma". This patch
>  is not that interesting to this patch series for risc-v. There are instances in
>  arch directories where VM_SHADOW_STACK flag is anyways used. Dropping this patch
>  to expedite merging in riscv tree.
>- Took suggestions from `Clement` on "riscv: zicfiss / zicfilp enumeration" to
>  validate presence of cfi based on config.
>- Added a patch for vDSO to have `lpad 0`. I had omitted this earlier to make sure
>  we add single vdso object with cfi enabled. But a vdso object with scheme of
>  zero labeled landing pad is least common denominator and should work with all
>  objects of zero labeled as well as function-signature labeled objects.
>
>v9:
>- rebased on master (39a803b754d5 fix braino in "9p: fix ->rename_sem exclusion")
>- dropped "mm: Introduce ARCH_HAS_USER_SHADOW_STACK" (master has it from arm64/gcs)
>- dropped "prctl: arch-agnostic prctl for shadow stack" (master has it from arm64/gcs)
>
>v8:
>- rebased on palmer/for-next
>- dropped samuel holland's `envcfg` context switch patches.
>  they are in parlmer/for-next
>
>v7:
>- Removed "riscv/Kconfig: enable HAVE_EXIT_THREAD for riscv"
>  Instead using `deactivate_mm` flow to clean up.
>  see here for more context
>  https://lore.kernel.org/all/20230908203655.543765-1-rick.p.edgecombe@intel.com/#t
>- Changed the header include in `kselftest`. Hopefully this fixes compile
>  issue faced by Zong Li at SiFive.
>- Cleaned up an orphaned change to `mm/mmap.c` in below patch
>  "riscv/mm : ensure PROT_WRITE leads to VM_READ | VM_WRITE"
>- Lock interfaces for shadow stack and indirect branch tracking expect arg == 0
>  Any future evolution of this interface should accordingly define how arg should
>  be setup.
>- `mm/map.c` has an instance of using `VM_SHADOW_STACK`. Fixed it to use helper
>  `is_shadow_stack_vma`.
>- Link to v6: https://lore.kernel.org/r/20241008-v5_user_cfi_series-v6-0-60d9fe073f37@rivosinc.com
>
>v6:
>- Picked up Samuel Holland's changes as is with `envcfg` placed in
>  `thread` instead of `thread_info`
>- fixed unaligned newline escapes in kselftest
>- cleaned up messages in kselftest and included test output in commit message
>- fixed a bug in clone path reported by Zong Li
>- fixed a build issue if CONFIG_RISCV_ISA_V is not selected
>  (this was introduced due to re-factoring signal context
>  management code)
>
>v5:
>- rebased on v6.12-rc1
>- Fixed schema related issues in device tree file
>- Fixed some of the documentation related issues in zicfilp/ss.rst
>  (style issues and added index)
>- added `SHADOW_STACK_SET_MARKER` so that implementation can define base
>  of shadow stack.
>- Fixed warnings on definitions added in usercfi.h when
>  CONFIG_RISCV_USER_CFI is not selected.
>- Adopted context header based signal handling as proposed by Andy Chiu
>- Added support for enabling kernel mode access to shadow stack using
>  FWFT
>  (https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/src/ext-firmware-features.adoc)
>- Link to v5: https://lore.kernel.org/r/20241001-v5_user_cfi_series-v1-0-3ba65b6e550f@rivosinc.com
>  (Note: I had an issue in my workflow due to which version number wasn't
>  picked up correctly while sending out patches)
>
>v4:
>- rebased on 6.11-rc6
>- envcfg: Converged with Samuel Holland's patches for envcfg management on per-
>thread basis.
>- vma_is_shadow_stack is renamed to is_vma_shadow_stack
>- picked up Mark Brown's `ARCH_HAS_USER_SHADOW_STACK` patch
>- signal context: using extended context management to maintain compatibility.
>- fixed `-Wmissing-prototypes` compiler warnings for prctl functions
>- Documentation fixes and amending typos.
>- Link to v4: https://lore.kernel.org/all/20240912231650.3740732-1-debug@rivosinc.com/
>
>v3:
>- envcfg
>  logic to pick up base envcfg had a bug where `ENVCFG_CBZE` could have been
>  picked on per task basis, even though CPU didn't implement it. Fixed in
>   this series.
>
>- dt-bindings
>  As suggested, split into separate commit. fixed the messaging that spec is
>  in public review
>
>- arch_is_shadow_stack change
>  arch_is_shadow_stack changed to vma_is_shadow_stack
>
>- hwprobe
>  zicfiss / zicfilp if present will get enumerated in hwprobe
>
>- selftests
>  As suggested, added object and binary filenames to .gitignore
>  Selftest binary anyways need to be compiled with cfi enabled compiler which
>  will make sure that landing pad and shadow stack are enabled. Thus removed
>  separate enable/disable tests. Cleaned up tests a bit.
>
>- Link to v3: https://lore.kernel.org/lkml/20240403234054.2020347-1-debug@rivosinc.com/
>
>v2:
>- Using config `CONFIG_RISCV_USER_CFI`, kernel support for riscv control flow
>  integrity for user mode programs can be compiled in the kernel.
>
>- Enabling of control flow integrity for user programs is left to user runtime
>
>- This patch series introduces arch agnostic `prctls` to enable shadow stack
>  and indirect branch tracking. And implements them on riscv.
>
>---
>Changes in v16:
>- Link to v15: https://lore.kernel.org/r/20250502-v5_user_cfi_series-v15-0-914966471885@rivosinc.com
>
>Changes in v15:
>- changelog posted just below cover letter
>- Link to v14: https://lore.kernel.org/r/20250429-v5_user_cfi_series-v14-0-5239410d012a@rivosinc.com
>
>Changes in v14:
>
>- changelog posted just below cover letter
>- Link to v13: https://lore.kernel.org/r/20250424-v5_user_cfi_series-v13-0-971437de586a@rivosinc.com
>
>Changes in v13:
>- changelog posted just below cover letter
>- Link to v12: https://lore.kernel.org/r/20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com
>
>Changes in v12:
>- changelog posted just below cover letter
>- Link to v11: https://lore.kernel.org/r/20250310-v5_user_cfi_series-v11-0-86b36cbfb910@rivosinc.com
>
>Changes in v11:
>- changelog posted just below cover letter
>- Link to v10: https://lore.kernel.org/r/20250210-v5_user_cfi_series-v10-0-163dcfa31c60@rivosinc.com
>
>---
>Andy Chiu (1):
>      riscv: signal: abstract header saving for setup_sigcontext
>
>Deepak Gupta (25):
>      mm: VM_SHADOW_STACK definition for riscv
>      dt-bindings: riscv: zicfilp and zicfiss in dt-bindings (extensions.yaml)
>      riscv: zicfiss / zicfilp enumeration
>      riscv: zicfiss / zicfilp extension csr and bit definitions
>      riscv: usercfi state for task and save/restore of CSR_SSP on trap entry/exit
>      riscv/mm : ensure PROT_WRITE leads to VM_READ | VM_WRITE
>      riscv mm: manufacture shadow stack pte
>      riscv mmu: teach pte_mkwrite to manufacture shadow stack PTEs
>      riscv mmu: write protect and shadow stack
>      riscv/mm: Implement map_shadow_stack() syscall
>      riscv/shstk: If needed allocate a new shadow stack on clone
>      riscv: Implements arch agnostic shadow stack prctls
>      prctl: arch-agnostic prctl for indirect branch tracking
>      riscv: Implements arch agnostic indirect branch tracking prctls
>      riscv/traps: Introduce software check exception
>      riscv/signal: save and restore of shadow stack for signal
>      riscv/kernel: update __show_regs to print shadow stack register
>      riscv/ptrace: riscv cfi status and state via ptrace and in core files
>      riscv/hwprobe: zicfilp / zicfiss enumeration in hwprobe
>      riscv: kernel command line option to opt out of user cfi
>      riscv: enable kernel access to shadow stack memory via FWFT sbi call
>      riscv: create a config for shadow stack and landing pad instr support
>      riscv: Documentation for landing pad / indirect branch tracking
>      riscv: Documentation for shadow stack on riscv
>      kselftest/riscv: kselftest for user mode cfi
>
>Jim Shu (1):
>      arch/riscv: compile vdso with landing pad
>
> Documentation/admin-guide/kernel-parameters.txt    |   8 +
> Documentation/arch/riscv/index.rst                 |   2 +
> Documentation/arch/riscv/zicfilp.rst               | 115 +++++
> Documentation/arch/riscv/zicfiss.rst               | 179 +++++++
> .../devicetree/bindings/riscv/extensions.yaml      |  14 +
> arch/riscv/Kconfig                                 |  21 +
> arch/riscv/Makefile                                |   5 +-
> arch/riscv/include/asm/asm-prototypes.h            |   1 +
> arch/riscv/include/asm/assembler.h                 |  44 ++
> arch/riscv/include/asm/cpufeature.h                |  12 +
> arch/riscv/include/asm/csr.h                       |  16 +
> arch/riscv/include/asm/entry-common.h              |   2 +
> arch/riscv/include/asm/hwcap.h                     |   2 +
> arch/riscv/include/asm/mman.h                      |  25 +
> arch/riscv/include/asm/mmu_context.h               |   7 +
> arch/riscv/include/asm/pgtable.h                   |  30 +-
> arch/riscv/include/asm/processor.h                 |   2 +
> arch/riscv/include/asm/thread_info.h               |   3 +
> arch/riscv/include/asm/usercfi.h                   |  95 ++++
> arch/riscv/include/asm/vector.h                    |   3 +
> arch/riscv/include/uapi/asm/hwprobe.h              |   2 +
> arch/riscv/include/uapi/asm/ptrace.h               |  34 ++
> arch/riscv/include/uapi/asm/sigcontext.h           |   1 +
> arch/riscv/kernel/Makefile                         |   1 +
> arch/riscv/kernel/asm-offsets.c                    |  10 +
> arch/riscv/kernel/cpufeature.c                     |  27 +
> arch/riscv/kernel/entry.S                          |  33 +-
> arch/riscv/kernel/head.S                           |  27 +
> arch/riscv/kernel/process.c                        |  26 +-
> arch/riscv/kernel/ptrace.c                         |  95 ++++
> arch/riscv/kernel/signal.c                         | 148 +++++-
> arch/riscv/kernel/sys_hwprobe.c                    |   2 +
> arch/riscv/kernel/sys_riscv.c                      |  10 +
> arch/riscv/kernel/traps.c                          |  43 ++
> arch/riscv/kernel/usercfi.c                        | 545 +++++++++++++++++++++
> arch/riscv/kernel/vdso/Makefile                    |   6 +
> arch/riscv/kernel/vdso/flush_icache.S              |   4 +
> arch/riscv/kernel/vdso/getcpu.S                    |   4 +
> arch/riscv/kernel/vdso/rt_sigreturn.S              |   4 +
> arch/riscv/kernel/vdso/sys_hwprobe.S               |   4 +
> arch/riscv/mm/init.c                               |   2 +-
> arch/riscv/mm/pgtable.c                            |  17 +
> include/linux/cpu.h                                |   4 +
> include/linux/mm.h                                 |   7 +
> include/uapi/linux/elf.h                           |   2 +
> include/uapi/linux/prctl.h                         |  27 +
> kernel/sys.c                                       |  30 ++
> tools/testing/selftests/riscv/Makefile             |   2 +-
> tools/testing/selftests/riscv/cfi/.gitignore       |   3 +
> tools/testing/selftests/riscv/cfi/Makefile         |  16 +
> tools/testing/selftests/riscv/cfi/cfi_rv_test.h    |  82 ++++
> tools/testing/selftests/riscv/cfi/riscv_cfi_test.c | 173 +++++++
> tools/testing/selftests/riscv/cfi/shadowstack.c    | 385 +++++++++++++++
> tools/testing/selftests/riscv/cfi/shadowstack.h    |  27 +
> 54 files changed, 2360 insertions(+), 29 deletions(-)
>---
>base-commit: 4181f8ad7a1061efed0219951d608d4988302af7
>change-id: 20240930-v5_user_cfi_series-3dc332f8f5b2
>--
>- debug
>

