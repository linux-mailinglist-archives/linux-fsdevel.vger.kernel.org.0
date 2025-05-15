Return-Path: <linux-fsdevel+bounces-49095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC24AB7E89
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 09:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24CB94C2C15
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 07:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB79283FC6;
	Thu, 15 May 2025 07:10:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2F41E5713;
	Thu, 15 May 2025 07:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747293033; cv=none; b=ovOndUH9cpY5kQbHeV7dQ0cpngdxPR0OnvuBN/PcbLVF2HMBCLxvnSM3u4Yw6feXllymGaRKM8GHx0Z6qKglFB0UXWtlpxsvm1oeVQ2ZSaG0UpCzZveMJ7sTcz1W3V0a/Gh82expNxEoaElw+fY7OZNj2J7ZpIhJdOdgPo4amHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747293033; c=relaxed/simple;
	bh=aEhxaXoZap2TnHxADSLhx4PG2xU6+iWBGWk4XlhDG1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sgyH4/dcT8dCKYPMuvZx35x8+Hsa9qtBa82baTQvNu6JaJRWMUkh3xQGKHK8LM2502GP+Slu9SD6bO0f/TiFOhw6xCngYpnYX81HFYUiNb/13YvPvJZmQ0t+xKfqEXIvLEu4aAU+GY44ctAiFgQ9JBD9THCV4L1CI5skpQspzA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id B7F9A43A81;
	Thu, 15 May 2025 07:10:11 +0000 (UTC)
Message-ID: <c911eead-30c4-497d-8a56-1450792b24bd@ghiti.fr>
Date: Thu, 15 May 2025 09:10:08 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 22/27] riscv: enable kernel access to shadow stack
 memory via FWFT sbi call
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
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
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
 Zong Li <zong.li@sifive.com>
References: <20250502-v5_user_cfi_series-v15-0-914966471885@rivosinc.com>
 <20250502-v5_user_cfi_series-v15-22-914966471885@rivosinc.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250502-v5_user_cfi_series-v15-22-914966471885@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdelvdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpeettdehkefghfekvdetteefgedvheejgfefhfekudeukeefieduudegtdehgffgueenucffohhmrghinhephhgvrggurdhssgenucfkphepvddttddumeekiedumeeffeekvdemvghfledtmeegsgejudemgegvtgeimeejfhehsgemjegstddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddttddumeekiedumeeffeekvdemvghfledtmeegsgejudemgegvtgeimeejfhehsgemjegstddupdhhvghloheplgfkrfggieemvddttddumeekiedumeeffeekvdemvghfledtmeegsgejudemgegvtgeimeejfhehsgemjegstddungdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopeehledprhgtphhtthhopeguvggsuhhgsehrihhvohhsihhntgdrtghomhdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehmihhnghhosehrvgguh
 hgrthdrtghomhdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopegurghvvgdrhhgrnhhsvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepgiekieeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhhprgesiiihthhorhdrtghomhdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhg
X-GND-Sasl: alex@ghiti.fr

Hi Deepak,

On 03/05/2025 01:30, Deepak Gupta wrote:
> Kernel will have to perform shadow stack operations on user shadow stack.
> Like during signal delivery and sigreturn, shadow stack token must be
> created and validated respectively. Thus shadow stack access for kernel
> must be enabled.
>
> In future when kernel shadow stacks are enabled for linux kernel, it must
> be enabled as early as possible for better coverage and prevent imbalance
> between regular stack and shadow stack. After `relocate_enable_mmu` has
> been done, this is as early as possible it can enabled.
>
> Reviewed-by: Zong Li <zong.li@sifive.com>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>   arch/riscv/kernel/asm-offsets.c |  4 ++++
>   arch/riscv/kernel/head.S        | 27 +++++++++++++++++++++++++++
>   2 files changed, 31 insertions(+)
>
> diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
> index f33945432f8f..7ab41f01aa17 100644
> --- a/arch/riscv/kernel/asm-offsets.c
> +++ b/arch/riscv/kernel/asm-offsets.c
> @@ -514,4 +514,8 @@ void asm_offsets(void)
>   	DEFINE(FREGS_A6,	    offsetof(struct __arch_ftrace_regs, a6));
>   	DEFINE(FREGS_A7,	    offsetof(struct __arch_ftrace_regs, a7));
>   #endif
> +	DEFINE(SBI_EXT_FWFT, SBI_EXT_FWFT);
> +	DEFINE(SBI_EXT_FWFT_SET, SBI_EXT_FWFT_SET);
> +	DEFINE(SBI_FWFT_SHADOW_STACK, SBI_FWFT_SHADOW_STACK);
> +	DEFINE(SBI_FWFT_SET_FLAG_LOCK, SBI_FWFT_SET_FLAG_LOCK);


kernel test robot reported errors when !RV64 and !SBI, the following 
diff fixes it:

diff --git a/arch/riscv/kernel/asm-offsets.c 
b/arch/riscv/kernel/asm-offsets.c
index 7fc085d27ca79..3aa5f56a84e9a 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -532,8 +532,10 @@ void asm_offsets(void)
         DEFINE(FREGS_A6,            offsetof(struct __arch_ftrace_regs, 
a6));
         DEFINE(FREGS_A7,            offsetof(struct __arch_ftrace_regs, 
a7));
  #endif
+#ifdef CONFIG_RISCV_SBI
         DEFINE(SBI_EXT_FWFT, SBI_EXT_FWFT);
         DEFINE(SBI_EXT_FWFT_SET, SBI_EXT_FWFT_SET);
         DEFINE(SBI_FWFT_SHADOW_STACK, SBI_FWFT_SHADOW_STACK);
         DEFINE(SBI_FWFT_SET_FLAG_LOCK, SBI_FWFT_SET_FLAG_LOCK);
+#endif
  }

No need to resend the whole series, I'll squash it.

Thanks,

Alex


>   }
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index 356d5397b2a2..7eae9a172351 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -15,6 +15,7 @@
>   #include <asm/image.h>
>   #include <asm/scs.h>
>   #include <asm/xip_fixup.h>
> +#include <asm/usercfi.h>
>   #include "efi-header.S"
>   
>   __HEAD
> @@ -164,6 +165,19 @@ secondary_start_sbi:
>   	call relocate_enable_mmu
>   #endif
>   	call .Lsetup_trap_vector
> +#if defined(CONFIG_RISCV_SBI) && defined(CONFIG_RISCV_USER_CFI)
> +	li a7, SBI_EXT_FWFT
> +	li a6, SBI_EXT_FWFT_SET
> +	li a0, SBI_FWFT_SHADOW_STACK
> +	li a1, 1 /* enable supervisor to access shadow stack access */
> +	li a2, SBI_FWFT_SET_FLAG_LOCK
> +	ecall
> +	beqz a0, 1f
> +	la a1, riscv_nousercfi
> +	li a0, CMDLINE_DISABLE_RISCV_USERCFI_BCFI
> +	REG_S a0, (a1)
> +1:
> +#endif
>   	scs_load_current
>   	call smp_callin
>   #endif /* CONFIG_SMP */
> @@ -320,6 +334,19 @@ SYM_CODE_START(_start_kernel)
>   	la tp, init_task
>   	la sp, init_thread_union + THREAD_SIZE
>   	addi sp, sp, -PT_SIZE_ON_STACK
> +#if defined(CONFIG_RISCV_SBI) && defined(CONFIG_RISCV_USER_CFI)
> +	li a7, SBI_EXT_FWFT
> +	li a6, SBI_EXT_FWFT_SET
> +	li a0, SBI_FWFT_SHADOW_STACK
> +	li a1, 1 /* enable supervisor to access shadow stack access */
> +	li a2, SBI_FWFT_SET_FLAG_LOCK
> +	ecall
> +	beqz a0, 1f
> +	la a1, riscv_nousercfi
> +	li a0, CMDLINE_DISABLE_RISCV_USERCFI_BCFI
> +	REG_S a0, (a1)
> +1:
> +#endif
>   	scs_load_current
>   
>   #ifdef CONFIG_KASAN
>

