Return-Path: <linux-fsdevel+bounces-45897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3239A7E55E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 17:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FB70176345
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 15:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78AA204F87;
	Mon,  7 Apr 2025 15:48:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4872046BE;
	Mon,  7 Apr 2025 15:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744040925; cv=none; b=btOVmjAZwQfDFLRoCOiQOlNUM9n786vI2fsR2FFcjosLePk65v/jhN4fuqmXJBP12VlX+yuhm5Tombzjo4Iidl8UAieX6Fhh9Q68JsGucbnQDyt3O6kQLEobRjvNIz+I4jgXMLZG8twCCjur1u5bUAB+BSsDPKiNAT2580IrLuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744040925; c=relaxed/simple;
	bh=GyPgyzHA5L8IKTlTgHkfyXtKVYHVaIGZCOvC3tTIRk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E5I4z437D0teXja8GnemTpdOS7XRuf7DG5fwPRIIXnUVPTzlPkx+aj8Gy5+5f0T/jFfncu6DmYnvojK/gJvHAkQ6GyHUCZofX83Lb8lE8wwbHC/1QXoO1LV9VrcGyqI5YJAAY0vEHvi8R1wizru4L4GcUExYrHLQdb5mEgX/vcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id D79204328B;
	Mon,  7 Apr 2025 15:48:27 +0000 (UTC)
Message-ID: <cc314da6-8755-4037-846b-01a20b3c68e1@ghiti.fr>
Date: Mon, 7 Apr 2025 17:48:27 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 03/28] riscv: zicfiss / zicfilp enumeration
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
 <20250314-v5_user_cfi_series-v12-3-e51202b53138@rivosinc.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20250314-v5_user_cfi_series-v12-3-e51202b53138@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtheelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptehlvgigrghnughrvgcuifhhihhtihcuoegrlhgvgiesghhhihhtihdrfhhrqeenucggtffrrghtthgvrhhnpedthfelfeejgeehveegleejleelgfevhfekieffkeeujeetfedvvefhledvgeegieenucfkphepudejiedrudegjedrudeghedrgeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudejiedrudegjedrudeghedrgeegpdhhvghloheplgduledvrdduieekrddurdduheefngdpmhgrihhlfhhrohhmpegrlhgvgiesghhhihhtihdrfhhrpdhnsggprhgtphhtthhopeegledprhgtphhtthhopeguvggsuhhgsehrihhvohhsihhntgdrtghomhdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopegurghvvgdrhhgrnhhsvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepgiekieeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhhpr
 gesiiihthhorhdrtghomhdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhg
X-GND-Sasl: alex@ghiti.fr


On 14/03/2025 22:39, Deepak Gupta wrote:
> This patch adds support for detecting zicfiss and zicfilp. zicfiss and
> zicfilp stands for unprivleged integer spec extension for shadow stack
> and branch tracking on indirect branches, respectively.
>
> This patch looks for zicfiss and zicfilp in device tree and accordinlgy
> lights up bit in cpu feature bitmap. Furthermore this patch adds detection
> utility functions to return whether shadow stack or landing pads are
> supported by cpu.
>
> Reviewed-by: Zong Li <zong.li@sifive.com>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>   arch/riscv/include/asm/cpufeature.h | 13 +++++++++++++
>   arch/riscv/include/asm/hwcap.h      |  2 ++
>   arch/riscv/include/asm/processor.h  |  1 +
>   arch/riscv/kernel/cpufeature.c      | 13 +++++++++++++
>   4 files changed, 29 insertions(+)
>
> diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
> index 569140d6e639..69007b8100ca 100644
> --- a/arch/riscv/include/asm/cpufeature.h
> +++ b/arch/riscv/include/asm/cpufeature.h
> @@ -12,6 +12,7 @@
>   #include <linux/kconfig.h>
>   #include <linux/percpu-defs.h>
>   #include <linux/threads.h>
> +#include <linux/smp.h>
>   #include <asm/hwcap.h>
>   #include <asm/cpufeature-macros.h>
>   
> @@ -137,4 +138,16 @@ static __always_inline bool riscv_cpu_has_extension_unlikely(int cpu, const unsi
>   	return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
>   }
>   
> +static inline bool cpu_supports_shadow_stack(void)
> +{
> +	return (IS_ENABLED(CONFIG_RISCV_USER_CFI) &&
> +		riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_ZICFISS));


I would use riscv_has_extension_unlikely() instead of the cpu specific 
variant, that would remove the need for #include <linux/smp.h>. Unless 
you have a good reason to do that?


> +}
> +
> +static inline bool cpu_supports_indirect_br_lp_instr(void)
> +{
> +	return (IS_ENABLED(CONFIG_RISCV_USER_CFI) &&
> +		riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_ZICFILP));
> +}
> +
>   #endif
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index 869da082252a..2dc4232bdb3e 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -100,6 +100,8 @@
>   #define RISCV_ISA_EXT_ZICCRSE		91
>   #define RISCV_ISA_EXT_SVADE		92
>   #define RISCV_ISA_EXT_SVADU		93
> +#define RISCV_ISA_EXT_ZICFILP		94
> +#define RISCV_ISA_EXT_ZICFISS		95
>   
>   #define RISCV_ISA_EXT_XLINUXENVCFG	127
>   
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> index 5f56eb9d114a..e3aba3336e63 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -13,6 +13,7 @@
>   #include <vdso/processor.h>
>   
>   #include <asm/ptrace.h>
> +#include <asm/hwcap.h>
>   
>   #define arch_get_mmap_end(addr, len, flags)			\
>   ({								\
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index c6ba750536c3..82065cc55822 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -150,6 +150,15 @@ static int riscv_ext_svadu_validate(const struct riscv_isa_ext_data *data,
>   	return 0;
>   }
>   
> +static int riscv_cfi_validate(const struct riscv_isa_ext_data *data,
> +			      const unsigned long *isa_bitmap)
> +{
> +	if (!IS_ENABLED(CONFIG_RISCV_USER_CFI))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>   static const unsigned int riscv_zk_bundled_exts[] = {
>   	RISCV_ISA_EXT_ZBKB,
>   	RISCV_ISA_EXT_ZBKC,
> @@ -333,6 +342,10 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>   	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicboz, RISCV_ISA_EXT_ZICBOZ, riscv_xlinuxenvcfg_exts,
>   					  riscv_ext_zicboz_validate),
>   	__RISCV_ISA_EXT_DATA(ziccrse, RISCV_ISA_EXT_ZICCRSE),
> +	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicfilp, RISCV_ISA_EXT_ZICFILP, riscv_xlinuxenvcfg_exts,
> +					  riscv_cfi_validate),
> +	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicfiss, RISCV_ISA_EXT_ZICFISS, riscv_xlinuxenvcfg_exts,
> +					  riscv_cfi_validate),
>   	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
>   	__RISCV_ISA_EXT_DATA(zicond, RISCV_ISA_EXT_ZICOND),
>   	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),
>

With the above comment fixed, you can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


