Return-Path: <linux-fsdevel+bounces-45936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BDEA7F89F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 10:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 280093BF592
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 08:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7443B264FA4;
	Tue,  8 Apr 2025 08:48:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF6A218587;
	Tue,  8 Apr 2025 08:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744102108; cv=none; b=D9KcebeZMJKXYaohr9wvfGRuYqCHdcZYW0sgtaM5Ph9zxjtu5/kN+rpRQkrNVq7pUEv5lLW/yTKcEbFfQyNB4dJFLeHvopzRMnbCfXXC4RkTno7WzjNrWHZYh4d5TbEwTRjXwvg+hypMpYidPUjCME4d1JsF+NNSg65Tz+fQ/gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744102108; c=relaxed/simple;
	bh=EKRfp60XCNJ7rg/cJg3WFzBihjWnzQtJhPEvpaboi2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XXNDnGWcF1gHZwCkROlS98SjmGi1KS9ORJS2eJvzg4nvvkomDAuVB3Qz4V0w/92G1btExwb3xjd+uGV85kiCHIh/7wGOhgubJJ7cPtPRgOyPlzpBMwMYQU4hFqv3E7te35oSdURV5QUVU0wmvFT33SJvqdCDIPK5kcfeVFX70E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 40BFF43409;
	Tue,  8 Apr 2025 08:48:09 +0000 (UTC)
Message-ID: <2a24cc43-4150-4a56-ba09-0d136dde893f@ghiti.fr>
Date: Tue, 8 Apr 2025 10:48:08 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 27/28] riscv: Documentation for shadow stack on riscv
Content-Language: en-US
To: Deepak Gupta <debug@rivosinc.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Christian Brauner <brauner@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>,
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
 rick.p.edgecombe@intel.com, Zong Li <zong.li@sifive.com>
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
 <20250314-v5_user_cfi_series-v12-27-e51202b53138@rivosinc.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250314-v5_user_cfi_series-v12-27-e51202b53138@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddvieegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpedthfelfeejgeehveegleejleelgfevhfekieffkeeujeetfedvvefhledvgeegieenucfkphepvddttddumeekiedumeeffeekvdemvghfledtmeehsgegieemkeeludekmegtledujeemjeekjedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddttddumeekiedumeeffeekvdemvghfledtmeehsgegieemkeeludekmegtledujeemjeekjedvpdhhvghloheplgfkrfggieemvddttddumeekiedumeeffeekvdemvghfledtmeehsgegieemkeeludekmegtledujeemjeekjedvngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopeegledprhgtphhtthhopeguvggsuhhgsehrihhvohhsihhntgdrtghomhdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthhopegsp
 hesrghlihgvnhekrdguvgdprhgtphhtthhopegurghvvgdrhhgrnhhsvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepgiekieeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhhprgesiiihthhorhdrtghomhdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhg
X-GND-Sasl: alex@ghiti.fr


On 14/03/2025 22:39, Deepak Gupta wrote:
> Adding documentation on shadow stack for user mode on riscv and kernel
> interfaces exposed so that user tasks can enable it.
>
> Reviewed-by: Zong Li <zong.li@sifive.com>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>   Documentation/arch/riscv/index.rst   |   1 +
>   Documentation/arch/riscv/zicfiss.rst | 176 +++++++++++++++++++++++++++++++++++
>   2 files changed, 177 insertions(+)
>
> diff --git a/Documentation/arch/riscv/index.rst b/Documentation/arch/riscv/index.rst
> index be7237b69682..e240eb0ceb70 100644
> --- a/Documentation/arch/riscv/index.rst
> +++ b/Documentation/arch/riscv/index.rst
> @@ -15,6 +15,7 @@ RISC-V architecture
>       vector
>       cmodx
>       zicfilp
> +    zicfiss
>   
>       features
>   
> diff --git a/Documentation/arch/riscv/zicfiss.rst b/Documentation/arch/riscv/zicfiss.rst
> new file mode 100644
> index 000000000000..5ba389f15b3f
> --- /dev/null
> +++ b/Documentation/arch/riscv/zicfiss.rst
> @@ -0,0 +1,176 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +:Author: Deepak Gupta <debug@rivosinc.com>
> +:Date:   12 January 2024
> +
> +=========================================================
> +Shadow stack to protect function returns on RISC-V Linux
> +=========================================================
> +
> +This document briefly describes the interface provided to userspace by Linux
> +to enable shadow stack for user mode applications on RISV-V


s/RISV-V/RISC-V and the final dot


> +
> +1. Feature Overview
> +--------------------
> +
> +Memory corruption issues usually result in to crashes, however when in hands of


s/in to/into


> +an adversary and if used creatively can result into variety security issues.


"into a variety of"


> +
> +One of those security issues can be code re-use attacks on program where
> +adversary can use corrupt return addresses present on stack and chain them
> +together to perform return oriented programming (ROP) and thus compromising
> +control flow integrity (CFI) of the program.
> +
> +Return addresses live on stack and thus in read-write memory and thus are
> +susceptible to corruption and allows an adversary to reach any program counter


s/and allows/which allows


> +(PC) in address space. On RISC-V ``zicfiss`` extension provides an alternate
> +stack termed as shadow stack on which return addresses can be safely placed in
> +prolog of the function and retrieved in epilog. ``zicfiss`` extension makes
> +following changes:
> +
> +- PTE encodings for shadow stack virtual memory
> +  An earlier reserved encoding in first stage translation i.e.
> +  PTE.R=0, PTE.W=1, PTE.X=0  becomes PTE encoding for shadow stack pages.
> +
> +- ``sspush x1/x5`` instruction pushes (stores) ``x1/x5`` to shadow stack.
> +
> +- ``sspopchk x1/x5`` instruction pops (loads) from shadow stack and compares
> +  with ``x1/x5`` and if un-equal, CPU raises ``software check exception`` with
> +  ``*tval = 3``
> +
> +Compiler toolchain makes sure that function prologue have ``sspush x1/x5`` to
> +save return address on shadow stack in addition to regular stack. Similarly
> +function epilogs have ``ld x5, offset(x2)`` followed by ``sspopchk x5`` to
> +ensure that popped value from regular stack matches with popped value from
> +shadow stack.
> +
> +2. Shadow stack protections and linux memory manager
> +-----------------------------------------------------
> +
> +As mentioned earlier, shadow stack get new page table encodings and thus have


s/shadow stack/shadow stacks


> +some special properties assigned to them and instructions that operate on them
> +as below:
> +
> +- Regular stores to shadow stack memory raises access store faults. This way
> +  shadow stack memory is protected from stray inadvertant writes.


s/inadvertant/inadvertent


> +
> +- Regular loads to shadow stack memory are allowed. This allows stack trace
> +  utilities or backtrace functions to read true callstack (not tampered).
> +
> +- Only shadow stack instructions can generate shadow stack load or shadow stack
> +  store.
> +
> +- Shadow stack load / shadow stack store on read-only memory raises AMO/store
> +  page fault. Thus both ``sspush x1/x5`` and ``sspopchk x1/x5`` will raise AMO/
> +  store page fault. This simplies COW handling in kernel During fork, kernel


s/During/during


> +  can convert shadow stack pages into read-only memory (as it does for regular
> +  read-write memory) and as soon as subsequent ``sspush`` or ``sspopchk`` in
> +  userspace is encountered, then kernel can perform COW.
> +
> +- Shadow stack load / shadow stack store on read-write, read-write-execute
> +  memory raises an access fault. This is a fatal condition because shadow stack
> +  should never be operating on read-write, read-write-execute memory.
> +
> +3. ELF and psABI
> +-----------------
> +
> +Toolchain sets up :c:macro:`GNU_PROPERTY_RISCV_FEATURE_1_BCFI` for property
> +:c:macro:`GNU_PROPERTY_RISCV_FEATURE_1_AND` in notes section of the object file.
> +
> +4. Linux enabling
> +------------------
> +
> +User space programs can have multiple shared objects loaded in its address space
> +and it's a difficult task to make sure all the dependencies have been compiled
> +with support of shadow stack. Thus it's left to dynamic loader to enable
> +shadow stack for the program.
> +
> +5. prctl() enabling
> +--------------------
> +
> +:c:macro:`PR_SET_SHADOW_STACK_STATUS` / :c:macro:`PR_GET_SHADOW_STACK_STATUS` /
> +:c:macro:`PR_LOCK_SHADOW_STACK_STATUS` are three prctls added to manage shadow
> +stack enabling for tasks. prctls are arch agnostic and returns -EINVAL on other
> +arches.
> +
> +* prctl(PR_SET_SHADOW_STACK_STATUS, unsigned long arg)
> +
> +If arg1 :c:macro:`PR_SHADOW_STACK_ENABLE` and if CPU supports ``zicfiss`` then
> +kernel will enable shadow stack for the task. Dynamic loader can issue this
> +:c:macro:`prctl` once it has determined that all the objects loaded in address
> +space have support for shadow stack. Additionally if there is a
> +:c:macro:`dlopen` to an object which wasn't compiled with ``zicfiss``, dynamic
> +loader can issue this prctl with arg1 set to 0 (i.e.
> +:c:macro:`PR_SHADOW_STACK_ENABLE` being clear)
> +
> +* prctl(PR_GET_SHADOW_STACK_STATUS, unsigned long *arg)
> +
> +Returns current status of indirect branch tracking. If enabled it'll return
> +:c:macro:`PR_SHADOW_STACK_ENABLE`.
> +
> +* prctl(PR_LOCK_SHADOW_STACK_STATUS, unsigned long arg)
> +
> +Locks current status of shadow stack enabling on the task. User space may want
> +to run with strict security posture and wouldn't want loading of objects
> +without ``zicfiss`` support in it and thus would want to disallow disabling of
> +shadow stack on current task. In that case user space can use this prctl to
> +lock current settings.
> +
> +5. violations related to returns with shadow stack enabled
> +-----------------------------------------------------------
> +
> +Pertaining to shadow stack, CPU raises software check exception in following
> +condition:
> +
> +- On execution of ``sspopchk x1/x5``, ``x1/x5`` didn't match top of shadow
> +  stack. If mismatch happens then cpu does ``*tval = 3`` and raise software
> +  check exception.
> +
> +Linux kernel will treat this as :c:macro:`SIGSEV`` with code =
> +:c:macro:`SEGV_CPERR` and follow normal course of signal delivery.
> +
> +6. Shadow stack tokens
> +-----------------------
> +Regular stores on shadow stacks are not allowed and thus can't be tampered
> +with via arbitrary stray writes due to bugs. Method of pivoting / switching to
> +shadow stack is simply writing to csr ``CSR_SSP`` changes active shadow stack.


I don't understand the end of this sentence.


> +This can be problematic because usually value to be written to ``CSR_SSP`` will
> +be loaded somewhere in writeable memory and thus allows an adversary to
> +corruption bug in software to pivot to an any address in shadow stack range.


Remove "an"


> +Shadow stack tokens can help mitigate this problem by making sure that:
> +
> +- When software is switching away from a shadow stack, shadow stack pointer
> +  should be saved on shadow stack itself and call it ``shadow stack token``
> +
> +- When software is switching to a shadow stack, it should read the
> +  ``shadow stack token`` from shadow stack pointer and verify that
> +  ``shadow stack token`` itself is pointer to shadow stack itself.
> +
> +- Once the token verification is done, software can perform the write to
> +  ``CSR_SSP`` to switch shadow stack.
> +
> +Here software can be user mode task runtime itself which is managing various
> +contexts as part of single thread. Software can be kernel as well when kernel
> +has to deliver a signal to user task and must save shadow stack pointer. Kernel
> +can perform similar procedure by saving a token on user shadow stack itself.
> +This way whenever :c:macro:`sigreturn` happens, kernel can read the token and
> +verify the token and then switch to shadow stack. Using this mechanism, kernel
> +helps user task so that any corruption issue in user task is not exploited by
> +adversary by arbitrarily using :c:macro:`sigreturn`. Adversary will have to
> +make sure that there is a ``shadow stack token`` in addition to invoking
> +:c:macro:`sigreturn`
> +
> +7. Signal shadow stack
> +-----------------------
> +Following structure has been added to sigcontext for RISC-V::
> +
> +    struct __sc_riscv_cfi_state {
> +        unsigned long ss_ptr;
> +    };
> +
> +As part of signal delivery, shadow stack token is saved on current shadow stack
> +itself and updated pointer is saved away in :c:macro:`ss_ptr` field in
> +:c:macro:`__sc_riscv_cfi_state` under :c:macro:`sigcontext`. Existing shadow
> +stack allocation is used for signal delivery. During :c:macro:`sigreturn`,
> +kernel will obtain :c:macro:`ss_ptr` from :c:macro:`sigcontext` and verify the
> +saved token on shadow stack itself and switch shadow stack.
>

