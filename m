Return-Path: <linux-fsdevel+bounces-45948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C76A7FC8F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 12:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 143A7189CF5F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 10:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB64267B83;
	Tue,  8 Apr 2025 10:39:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17EA266595;
	Tue,  8 Apr 2025 10:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744108774; cv=none; b=SDd8YRvXAfZ78/vRJRh8Q0uNweibTjpVCJ35P1njqucvvG/TC1RxFQak9tft+07olMH2LJbaZQGWGsFSM5NnMgtGQJGyudC9DXGIAkns3syPca3XjHx2q0/ag5fg/cM8E7KqNksqF5VEC+T3majLC4BKysUbashG3MPZpyXZqec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744108774; c=relaxed/simple;
	bh=9MjVRH9gj1+f5MDFfIfL7UmI6wmnt2YXQolaQypXD3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E3k6JKch2w+NtQF9CAXS2qh3/yHLomEwRRZwmxJ20leEggAe5aRFyPohUkgwPj1NIAdReHMkcf4jpSoGMGEzYtkki9eeJuFww7jPUHc5HSashNHIS5qI4evvNTsivcBnEfcTKNJ3If4RyQEqcxuWe4p+Y698D38DFgMLK97NcI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1670043280;
	Tue,  8 Apr 2025 10:39:16 +0000 (UTC)
Message-ID: <2c0a0c3a-368c-44cb-9d4b-245f5b3dada1@ghiti.fr>
Date: Tue, 8 Apr 2025 12:39:16 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 06/28] riscv/mm : ensure PROT_WRITE leads to VM_READ |
 VM_WRITE
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
 <20250314-v5_user_cfi_series-v12-6-e51202b53138@rivosinc.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250314-v5_user_cfi_series-v12-6-e51202b53138@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddvkeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpedthfelfeejgeehveegleejleelgfevhfekieffkeeujeetfedvvefhledvgeegieenucfkphepvddttddumeekiedumeeffeekvdemvghfledtmeehsgegieemkeeludekmegtledujeemjeekjedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddttddumeekiedumeeffeekvdemvghfledtmeehsgegieemkeeludekmegtledujeemjeekjedvpdhhvghloheplgfkrfggieemvddttddumeekiedumeeffeekvdemvghfledtmeehsgegieemkeeludekmegtledujeemjeekjedvngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopeegledprhgtphhtthhopeguvggsuhhgsehrihhvohhsihhntgdrtghomhdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthhopegsp
 hesrghlihgvnhekrdguvgdprhgtphhtthhopegurghvvgdrhhgrnhhsvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepgiekieeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhhprgesiiihthhorhdrtghomhdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhg
X-GND-Sasl: alex@ghiti.fr


On 14/03/2025 22:39, Deepak Gupta wrote:
> `arch_calc_vm_prot_bits` is implemented on risc-v to return VM_READ |
> VM_WRITE if PROT_WRITE is specified. Similarly `riscv_sys_mmap` is
> updated to convert all incoming PROT_WRITE to (PROT_WRITE | PROT_READ).
> This is to make sure that any existing apps using PROT_WRITE still work.
>
> Earlier `protection_map[VM_WRITE]` used to pick read-write PTE encodings.
> Now `protection_map[VM_WRITE]` will always pick PAGE_SHADOWSTACK PTE
> encodings for shadow stack. Above changes ensure that existing apps
> continue to work because underneath kernel will be picking
> `protection_map[VM_WRITE|VM_READ]` PTE encodings.
>
> Reviewed-by: Zong Li <zong.li@sifive.com>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>   arch/riscv/include/asm/mman.h    | 25 +++++++++++++++++++++++++
>   arch/riscv/include/asm/pgtable.h |  1 +
>   arch/riscv/kernel/sys_riscv.c    | 10 ++++++++++
>   arch/riscv/mm/init.c             |  2 +-
>   4 files changed, 37 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/mman.h b/arch/riscv/include/asm/mman.h
> new file mode 100644
> index 000000000000..392c9c2d2e78
> --- /dev/null
> +++ b/arch/riscv/include/asm/mman.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_MMAN_H__
> +#define __ASM_MMAN_H__
> +
> +#include <linux/compiler.h>
> +#include <linux/types.h>
> +#include <uapi/asm/mman.h>
> +
> +static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
> +						   unsigned long pkey __always_unused)
> +{
> +	unsigned long ret = 0;
> +
> +	/*
> +	 * If PROT_WRITE was specified, force it to VM_READ | VM_WRITE.
> +	 * Only VM_WRITE means shadow stack.
> +	 */
> +	if (prot & PROT_WRITE)
> +		ret = (VM_READ | VM_WRITE);
> +	return ret;
> +}
> +
> +#define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
> +
> +#endif /* ! __ASM_MMAN_H__ */
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 050fdc49b5ad..8c528cd7347a 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -178,6 +178,7 @@ extern struct pt_alloc_ops pt_ops __meminitdata;
>   #define PAGE_READ_EXEC		__pgprot(_PAGE_BASE | _PAGE_READ | _PAGE_EXEC)
>   #define PAGE_WRITE_EXEC		__pgprot(_PAGE_BASE | _PAGE_READ |	\
>   					 _PAGE_EXEC | _PAGE_WRITE)
> +#define PAGE_SHADOWSTACK       __pgprot(_PAGE_BASE | _PAGE_WRITE)
>   
>   #define PAGE_COPY		PAGE_READ
>   #define PAGE_COPY_EXEC		PAGE_READ_EXEC
> diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
> index d77afe05578f..43a448bf254b 100644
> --- a/arch/riscv/kernel/sys_riscv.c
> +++ b/arch/riscv/kernel/sys_riscv.c
> @@ -7,6 +7,7 @@
>   
>   #include <linux/syscalls.h>
>   #include <asm/cacheflush.h>
> +#include <asm-generic/mman-common.h>
>   
>   static long riscv_sys_mmap(unsigned long addr, unsigned long len,
>   			   unsigned long prot, unsigned long flags,
> @@ -16,6 +17,15 @@ static long riscv_sys_mmap(unsigned long addr, unsigned long len,
>   	if (unlikely(offset & (~PAGE_MASK >> page_shift_offset)))
>   		return -EINVAL;
>   
> +	/*
> +	 * If PROT_WRITE is specified then extend that to PROT_READ
> +	 * protection_map[VM_WRITE] is now going to select shadow stack encodings.
> +	 * So specifying PROT_WRITE actually should select protection_map [VM_WRITE | VM_READ]
> +	 * If user wants to create shadow stack then they should use `map_shadow_stack` syscall.
> +	 */
> +	if (unlikely((prot & PROT_WRITE) && !(prot & PROT_READ)))
> +		prot |= PROT_READ;
> +
>   	return ksys_mmap_pgoff(addr, len, prot, flags, fd,
>   			       offset >> (PAGE_SHIFT - page_shift_offset));
>   }
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 15b2eda4c364..9d6661638d0b 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -342,7 +342,7 @@ pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
>   static const pgprot_t protection_map[16] = {
>   	[VM_NONE]					= PAGE_NONE,
>   	[VM_READ]					= PAGE_READ,
> -	[VM_WRITE]					= PAGE_COPY,
> +	[VM_WRITE]					= PAGE_SHADOWSTACK,
>   	[VM_WRITE | VM_READ]				= PAGE_COPY,
>   	[VM_EXEC]					= PAGE_EXEC,
>   	[VM_EXEC | VM_READ]				= PAGE_READ_EXEC,
>

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>


