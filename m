Return-Path: <linux-fsdevel+bounces-45930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBB9A7F746
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 10:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3F68188B698
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 08:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212DC263F47;
	Tue,  8 Apr 2025 08:06:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488A725F96E;
	Tue,  8 Apr 2025 08:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744099566; cv=none; b=K2pKLO4ImMt7alHCDlnt6drhYm0bL7RkXtRqaV5pQAXkqZSvOMyLiccJg58vVdTo98onPp5OM9jjQsylsv91glt3pveiXeubJV8LivMhJHJiu17rMZF17zI0jS7vgrw4JGZF/tkgdA49+WOyz4GyyJ82EwGTIl7uETS1XrS0erQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744099566; c=relaxed/simple;
	bh=80EgAG7HXUHwaTNBiNtJabzbql9J8NHwuJwaMe4c7lU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KyMXoUDGBQ8st2WM5+KTYMFQ9YZCD8S6ouEoRgxIwDlFY6YEhOhph8MpW3PWhd9xfi1daNLecRxIrwObBNFrpuAvYUa3A6sFx0kB1SOtbBd2hIyx64sLlAQGMBSvWrk4T91kAnb391vlRj8v7Lpfo76zfZqkFHFlOfPNVXKz/Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id B0E3744445;
	Tue,  8 Apr 2025 08:05:49 +0000 (UTC)
Message-ID: <cbc057b9-e3ec-4750-aad4-0cc813b65b07@ghiti.fr>
Date: Tue, 8 Apr 2025 10:05:48 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 05/28] riscv: usercfi state for task and save/restore
 of CSR_SSP on trap entry/exit
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
 <20250314-v5_user_cfi_series-v12-5-e51202b53138@rivosinc.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250314-v5_user_cfi_series-v12-5-e51202b53138@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddvheeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpefhlefhffeggfeftddvtdeukeelgfehkeehhfeuheehleefkeelgffglefghfffueenucffohhmrghinhepvghnthhrhidrshgsnecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemhegsgeeimeekledukeemtgeludejmeejkeejvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemfeefkedvmegvfheltdemhegsgeeimeekledukeemtgeludejmeejkeejvddphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemhegsgeeimeekledukeemtgeludejmeejkeejvdgnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepgeelpdhrtghpthhtohepuggvsghughesrhhivhhoshhinhgtrdgtohhmpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepmhhinhhgohesrhgvu
 ghhrghtrdgtohhmpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepuggrvhgvrdhhrghnshgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhphgrseiihihtohhrrdgtohhmpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrgh
X-GND-Sasl: alex@ghiti.fr

On 14/03/2025 22:39, Deepak Gupta wrote:
> Carves out space in arch specific thread struct for cfi status and shadow
> stack in usermode on riscv.
>
> This patch does following
> - defines a new structure cfi_status with status bit for cfi feature
> - defines shadow stack pointer, base and size in cfi_status structure
> - defines offsets to new member fields in thread in asm-offsets.c
> - Saves and restore shadow stack pointer on trap entry (U --> S) and exit
>    (S --> U)
>
> Shadow stack save/restore is gated on feature availiblity and implemented
> using alternative. CSR can be context switched in `switch_to` as well but
> soon as kernel shadow stack support gets rolled in, shadow stack pointer
> will need to be switched at trap entry/exit point (much like `sp`). It can
> be argued that kernel using shadow stack deployment scenario may not be as
> prevalant as user mode using this feature. But even if there is some
> minimal deployment of kernel shadow stack, that means that it needs to be
> supported. And thus save/restore of shadow stack pointer in entry.S instead
> of in `switch_to.h`.
>
> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
> Reviewed-by: Zong Li <zong.li@sifive.com>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>   arch/riscv/include/asm/processor.h   |  1 +
>   arch/riscv/include/asm/thread_info.h |  3 +++
>   arch/riscv/include/asm/usercfi.h     | 24 ++++++++++++++++++++++++
>   arch/riscv/kernel/asm-offsets.c      |  4 ++++
>   arch/riscv/kernel/entry.S            | 26 ++++++++++++++++++++++++++
>   5 files changed, 58 insertions(+)
>
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> index e3aba3336e63..d851bb5c6da0 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -14,6 +14,7 @@
>   
>   #include <asm/ptrace.h>
>   #include <asm/hwcap.h>
> +#include <asm/usercfi.h>
>   
>   #define arch_get_mmap_end(addr, len, flags)			\
>   ({								\
> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
> index f5916a70879a..a0cfe00c2ca6 100644
> --- a/arch/riscv/include/asm/thread_info.h
> +++ b/arch/riscv/include/asm/thread_info.h
> @@ -62,6 +62,9 @@ struct thread_info {
>   	long			user_sp;	/* User stack pointer */
>   	int			cpu;
>   	unsigned long		syscall_work;	/* SYSCALL_WORK_ flags */
> +#ifdef CONFIG_RISCV_USER_CFI
> +	struct cfi_status	user_cfi_state;
> +#endif
>   #ifdef CONFIG_SHADOW_CALL_STACK
>   	void			*scs_base;
>   	void			*scs_sp;
> diff --git a/arch/riscv/include/asm/usercfi.h b/arch/riscv/include/asm/usercfi.h
> new file mode 100644
> index 000000000000..5f2027c51917
> --- /dev/null
> +++ b/arch/riscv/include/asm/usercfi.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + * Copyright (C) 2024 Rivos, Inc.
> + * Deepak Gupta <debug@rivosinc.com>
> + */
> +#ifndef _ASM_RISCV_USERCFI_H
> +#define _ASM_RISCV_USERCFI_H
> +
> +#ifndef __ASSEMBLY__
> +#include <linux/types.h>
> +
> +#ifdef CONFIG_RISCV_USER_CFI
> +struct cfi_status {
> +	unsigned long ubcfi_en : 1; /* Enable for backward cfi. */
> +	unsigned long rsvd : ((sizeof(unsigned long) * 8) - 1);
> +	unsigned long user_shdw_stk; /* Current user shadow stack pointer */
> +	unsigned long shdw_stk_base; /* Base address of shadow stack */
> +	unsigned long shdw_stk_size; /* size of shadow stack */
> +};
> +
> +#endif /* CONFIG_RISCV_USER_CFI */
> +
> +#endif /* __ASSEMBLY__ */
> +
> +#endif /* _ASM_RISCV_USERCFI_H */
> diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
> index e89455a6a0e5..0c188aaf3925 100644
> --- a/arch/riscv/kernel/asm-offsets.c
> +++ b/arch/riscv/kernel/asm-offsets.c
> @@ -50,6 +50,10 @@ void asm_offsets(void)
>   #endif
>   
>   	OFFSET(TASK_TI_CPU_NUM, task_struct, thread_info.cpu);
> +#ifdef CONFIG_RISCV_USER_CFI
> +	OFFSET(TASK_TI_CFI_STATUS, task_struct, thread_info.user_cfi_state);
> +	OFFSET(TASK_TI_USER_SSP, task_struct, thread_info.user_cfi_state.user_shdw_stk);
> +#endif
>   	OFFSET(TASK_THREAD_F0,  task_struct, thread.fstate.f[0]);
>   	OFFSET(TASK_THREAD_F1,  task_struct, thread.fstate.f[1]);
>   	OFFSET(TASK_THREAD_F2,  task_struct, thread.fstate.f[2]);
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 33a5a9f2a0d4..68c99124ea55 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -147,6 +147,20 @@ SYM_CODE_START(handle_exception)
>   
>   	REG_L s0, TASK_TI_USER_SP(tp)
>   	csrrc s1, CSR_STATUS, t0
> +	/*
> +	 * If previous mode was U, capture shadow stack pointer and save it away
> +	 * Zero CSR_SSP at the same time for sanitization.
> +	 */
> +	ALTERNATIVE("nop; nop; nop; nop",


You could use __nops(4) here instead.


> +				__stringify(			\
> +				andi s2, s1, SR_SPP;	\
> +				bnez s2, skip_ssp_save;	\
> +				csrrw s2, CSR_SSP, x0;	\
> +				REG_S s2, TASK_TI_USER_SSP(tp); \
> +				skip_ssp_save:),
> +				0,
> +				RISCV_ISA_EXT_ZICFISS,
> +				CONFIG_RISCV_USER_CFI)
>   	csrr s2, CSR_EPC
>   	csrr s3, CSR_TVAL
>   	csrr s4, CSR_CAUSE
> @@ -236,6 +250,18 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
>   	 * structures again.
>   	 */
>   	csrw CSR_SCRATCH, tp
> +
> +	/*
> +	 * Going back to U mode, restore shadow stack pointer
> +	 */
> +	ALTERNATIVE("nop; nop",


Ditto


> +				__stringify(					\
> +				REG_L s3, TASK_TI_USER_SSP(tp); \
> +				csrw CSR_SSP, s3),
> +				0,
> +				RISCV_ISA_EXT_ZICFISS,
> +				CONFIG_RISCV_USER_CFI)
> +
>   1:
>   #ifdef CONFIG_RISCV_ISA_V_PREEMPTIVE
>   	move a0, sp
>
Apart from the nits above, you can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex



