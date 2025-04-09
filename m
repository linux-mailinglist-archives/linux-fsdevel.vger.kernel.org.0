Return-Path: <linux-fsdevel+bounces-46093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 489D3A82799
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 16:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C4138A57BE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 14:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CA7266B7D;
	Wed,  9 Apr 2025 14:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="hBqsiEd6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261AD265CDC
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Apr 2025 14:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744208376; cv=none; b=X46T+5fmHOXi/oW+csUxHn0YODqgP08gw9R1/qxAYlxWy4tqSNuclG9A2gflsHHMv8CdUcw8GTffIdxDsRPxn4pHiPSRaOKnnQ4N1iwmoLLJEBk9Xd4c9Pi1C75GTHgdIcxKvdkQQ3ZIih1Qwqy7NMf6IWqYmMyCYi/jfwNf9/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744208376; c=relaxed/simple;
	bh=OOjJOvnWzYhl5ueHhGfrtSt26gt/470fHuPjWSU/0Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rAHFC3btAcbiLJIxJvRSgwJAniNlRRZ12FDpZIQ+4jdKt2IwKqmJqi5HpIDczD70+FCOgTVtCqko3rh7YKrmviU5CwQSXaWJ7wPU2c7QSYj0A0qcru+uu2IO7H5D+dtqrIsD3njcPJo0oshFbCalp+H2qRn6rJXXIhYzUSPvdVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=hBqsiEd6; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-225df540edcso9080795ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Apr 2025 07:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1744208372; x=1744813172; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oOgTt3TJCCtZC0mLU59SS0hlKxJUYGJ18JNxrJvKvcQ=;
        b=hBqsiEd6SoXe8PkOCerS5pqc/AVlx/Dh87oGF7jZnFAoNhMxOGPYCu88LoezMoVqGQ
         UQbwbrh54R3Gay9oGopM3IutE5OGcDx/LzRPxZ293p3rwOtTb0dZx8wDW34uYt/c807s
         JabfoJNq6JlxpteaJM/TvaDJ7ofWVeSVXx+lNK+TV0edvdvkWHklkxKkcWH0nDauEinE
         VURbnCyFGRFPiswvTFVBBAC48qHWkO6xkb5Jmt+ayw2GWxF9mvKbn8c73EIQXfKer67x
         IebGxmtKEQHW3bVVzvjNTSUNQhbjQYoLDRgPE61YJJb2rWfejsPCV0w7yuG1B8Zu2hWX
         nHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744208372; x=1744813172;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oOgTt3TJCCtZC0mLU59SS0hlKxJUYGJ18JNxrJvKvcQ=;
        b=s6NTsE+34KRh9XOA//STQZPlRhPFZ4+lXFgNcvvugJgXuDXAzyMiuqgLAZjbGDQ7ZP
         d8/4GxICMeG6JhCK2s5i5roXnCe4m2vv99dtwajg4OO6M8Zme+z4Yf6pAhHaNEbpAlPf
         FGjQD9pOVzMik1FA1IXmppgs8fvfdL2jphjBdwvC7F/M8myuviYnbBa98GkdQC30L9QX
         LBrORUAKhymvTO9HJwCwLRO+F1dH0LqWu64x0xRgtxzbWkZJC+sOzFXpNO7YrfHyp7Fb
         L1piBFixXEzoSm9ZI6R7R3lvXjlSIc0MaHlsuD10Abw78vCKkETR8uN62yZzD8nc+Fok
         js/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWbAVh43+zk13NV+b3Ovf2yZ2FWKvbT1VvtF4yTnnGFrIidmtLCi+pyq4+mOV2IDUHXJnj7Vi9EXIsKlluq@vger.kernel.org
X-Gm-Message-State: AOJu0YydW5nM6MKwKNiVad4t7Zfs4Z4qKCLzwgWntWy2j/25adDEstXj
	4TrEKzlufzBR26QZOEb/+SMuzux/vyLxaF5vNb2xH4rYoHzwcuMRzMxBY+WJ/h4=
X-Gm-Gg: ASbGncvXSMi2Vk94CTEMsqF/MqKIzIYy+59rOfBjR9RcFzI8+lngbU3ltaES1nRTC+B
	U2ZhLC1TNXrTy4lWDDJ8FsRCl3hzLu3EG8V/k64F438Uh2FWj6lZgIlyEeW4elRRSQ++ztMSyY9
	1TiGRvL2GEOCC12G12hAKWWKwYFLScPyFiioBjUL05G5+zfWaXH9XIhlRxqGTwm4cltMtM0s07P
	1Ax6ughAErBxq8nK2VE3lsopi3dO33V4ylbFOOECGEGuTwfdwOIai8iMFIpr2B1wkIKSDC1r2qY
	aaJiA8fXIuWjhofSUD0CFXqKRZY3FnH02C/BJcenHuCh6d5S9jQ=
X-Google-Smtp-Source: AGHT+IEahP8JSiSgxvTh2n1gKbLAyTu8vcSecPJE9+mInATF99BTGal5h90YFsqI5Wz0yhAcDuqM7w==
X-Received: by 2002:a17:902:cec5:b0:215:a2f4:d4ab with SMTP id d9443c01a7336-22ac324879cmr39874945ad.7.1744208372199;
        Wed, 09 Apr 2025 07:19:32 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7c97a1bsm12321045ad.148.2025.04.09.07.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 07:19:31 -0700 (PDT)
Date: Wed, 9 Apr 2025 07:19:28 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Zong Li <zong.li@sifive.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
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
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	alistair.francis@wdc.com, richard.henderson@linaro.org,
	jim.shu@sifive.com, andybnac@gmail.com, kito.cheng@sifive.com,
	charlie@rivosinc.com, atishp@rivosinc.com, evan@rivosinc.com,
	cleger@rivosinc.com, alexghiti@rivosinc.com,
	samitolvanen@google.com, broonie@kernel.org,
	rick.p.edgecombe@intel.com
Subject: Re: [PATCH v12 10/28] riscv/mm: Implement map_shadow_stack() syscall
Message-ID: <Z_aB8EoaqccRz8tn@debug.ba.rivosinc.com>
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
 <20250314-v5_user_cfi_series-v12-10-e51202b53138@rivosinc.com>
 <CANXhq0rpHMWvJhWNUKuiMvJZoqN5iTz7USmZYHff=se-+-H+3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANXhq0rpHMWvJhWNUKuiMvJZoqN5iTz7USmZYHff=se-+-H+3w@mail.gmail.com>

On Mon, Apr 07, 2025 at 12:50:35PM +0800, Zong Li wrote:
>On Sat, Mar 15, 2025 at 5:39 AM Deepak Gupta <debug@rivosinc.com> wrote:
>>
>> As discussed extensively in the changelog for the addition of this
>> syscall on x86 ("x86/shstk: Introduce map_shadow_stack syscall") the
>> existing mmap() and madvise() syscalls do not map entirely well onto the
>> security requirements for shadow stack memory since they lead to windows
>> where memory is allocated but not yet protected or stacks which are not
>> properly and safely initialised. Instead a new syscall map_shadow_stack()
>> has been defined which allocates and initialises a shadow stack page.
>>
>> This patch implements this syscall for riscv. riscv doesn't require token
>> to be setup by kernel because user mode can do that by itself. However to
>> provide compatibility and portability with other architectues, user mode
>> can specify token set flag.
>>
>> Reviewed-by: Zong Li <zong.li@sifive.com>
>> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>> ---
>>  arch/riscv/kernel/Makefile  |   1 +
>>  arch/riscv/kernel/usercfi.c | 144 ++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 145 insertions(+)
>>
>> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
>> index 8d186bfced45..3a861d320654 100644
>> --- a/arch/riscv/kernel/Makefile
>> +++ b/arch/riscv/kernel/Makefile
>> @@ -125,3 +125,4 @@ obj-$(CONFIG_ACPI)          += acpi.o
>>  obj-$(CONFIG_ACPI_NUMA)        += acpi_numa.o
>>
>>  obj-$(CONFIG_GENERIC_CPU_VULNERABILITIES) += bugs.o
>> +obj-$(CONFIG_RISCV_USER_CFI) += usercfi.o
>> diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
>> new file mode 100644
>> index 000000000000..24022809a7b5
>> --- /dev/null
>> +++ b/arch/riscv/kernel/usercfi.c
>> @@ -0,0 +1,144 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2024 Rivos, Inc.
>> + * Deepak Gupta <debug@rivosinc.com>
>> + */
>> +
>> +#include <linux/sched.h>
>> +#include <linux/bitops.h>
>> +#include <linux/types.h>
>> +#include <linux/mm.h>
>> +#include <linux/mman.h>
>> +#include <linux/uaccess.h>
>> +#include <linux/sizes.h>
>> +#include <linux/user.h>
>> +#include <linux/syscalls.h>
>> +#include <linux/prctl.h>
>> +#include <asm/csr.h>
>> +#include <asm/usercfi.h>
>> +
>> +#define SHSTK_ENTRY_SIZE sizeof(void *)
>> +
>> +/*
>> + * Writes on shadow stack can either be `sspush` or `ssamoswap`. `sspush` can happen
>> + * implicitly on current shadow stack pointed to by CSR_SSP. `ssamoswap` takes pointer to
>> + * shadow stack. To keep it simple, we plan to use `ssamoswap` to perform writes on shadow
>> + * stack.
>> + */
>> +static noinline unsigned long amo_user_shstk(unsigned long *addr, unsigned long val)
>> +{
>> +       /*
>> +        * Never expect -1 on shadow stack. Expect return addresses and zero
>> +        */
>> +       unsigned long swap = -1;
>> +
>> +       __enable_user_access();
>> +       asm goto(
>> +               ".option push\n"
>> +               ".option arch, +zicfiss\n"
>> +               "1: ssamoswap.d %[swap], %[val], %[addr]\n"
>
>Hi Deepak,
>It just came to my mind, do we need to ensure that menvcfg.SSE is not
>zero before executing the ssamoswap instruction? Since ssamoswap is
>not encoded using MOP, I’m wondering if we should make sure that
>executing ssamoswap won’t accidentally trigger an illegal instruction
>exception. Thanks.

FWFT patches turn SSE during early boot. There is a bug there though,
I need to check if those FWFT SBI call succeeded or not. If it failed
then itshould set a global variable indicating shadow stack can't be
turned on. And in that case this flow wouldn't be reachable. Soon I
will post v13 with these changes.

Thanks for noticing.
>
>> +               _ASM_EXTABLE(1b, %l[fault])
>> +               RISCV_ACQUIRE_BARRIER
>> +               ".option pop\n"
>> +               : [swap] "=r" (swap), [addr] "+A" (*addr)
>> +               : [val] "r" (val)
>> +               : "memory"
>> +               : fault
>> +               );
>> +       __disable_user_access();
>> +       return swap;
>> +fault:
>> +       __disable_user_access();
>> +       return -1;
>> +}
>> +
>> +/*
>> + * Create a restore token on the shadow stack.  A token is always XLEN wide
>> + * and aligned to XLEN.
>> + */
>> +static int create_rstor_token(unsigned long ssp, unsigned long *token_addr)
>> +{
>> +       unsigned long addr;
>> +
>> +       /* Token must be aligned */
>> +       if (!IS_ALIGNED(ssp, SHSTK_ENTRY_SIZE))
>> +               return -EINVAL;
>> +
>> +       /* On RISC-V we're constructing token to be function of address itself */
>> +       addr = ssp - SHSTK_ENTRY_SIZE;
>> +
>> +       if (amo_user_shstk((unsigned long __user *)addr, (unsigned long)ssp) == -1)
>> +               return -EFAULT;
>> +
>> +       if (token_addr)
>> +               *token_addr = addr;
>> +
>> +       return 0;
>> +}
>> +
>> +static unsigned long allocate_shadow_stack(unsigned long addr, unsigned long size,
>> +                                          unsigned long token_offset, bool set_tok)
>> +{
>> +       int flags = MAP_ANONYMOUS | MAP_PRIVATE;
>> +       struct mm_struct *mm = current->mm;
>> +       unsigned long populate, tok_loc = 0;
>> +
>> +       if (addr)
>> +               flags |= MAP_FIXED_NOREPLACE;
>> +
>> +       mmap_write_lock(mm);
>> +       addr = do_mmap(NULL, addr, size, PROT_READ, flags,
>> +                      VM_SHADOW_STACK | VM_WRITE, 0, &populate, NULL);
>> +       mmap_write_unlock(mm);
>> +
>> +       if (!set_tok || IS_ERR_VALUE(addr))
>> +               goto out;
>> +
>> +       if (create_rstor_token(addr + token_offset, &tok_loc)) {
>> +               vm_munmap(addr, size);
>> +               return -EINVAL;
>> +       }
>> +
>> +       addr = tok_loc;
>> +
>> +out:
>> +       return addr;
>> +}
>> +
>> +SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, size, unsigned int, flags)
>> +{
>> +       bool set_tok = flags & SHADOW_STACK_SET_TOKEN;
>> +       unsigned long aligned_size = 0;
>> +
>> +       if (!cpu_supports_shadow_stack())
>> +               return -EOPNOTSUPP;
>> +
>> +       /* Anything other than set token should result in invalid param */
>> +       if (flags & ~SHADOW_STACK_SET_TOKEN)
>> +               return -EINVAL;
>> +
>> +       /*
>> +        * Unlike other architectures, on RISC-V, SSP pointer is held in CSR_SSP and is available
>> +        * CSR in all modes. CSR accesses are performed using 12bit index programmed in instruction
>> +        * itself. This provides static property on register programming and writes to CSR can't
>> +        * be unintentional from programmer's perspective. As long as programmer has guarded areas
>> +        * which perform writes to CSR_SSP properly, shadow stack pivoting is not possible. Since
>> +        * CSR_SSP is writeable by user mode, it itself can setup a shadow stack token subsequent
>> +        * to allocation. Although in order to provide portablity with other architecture (because
>> +        * `map_shadow_stack` is arch agnostic syscall), RISC-V will follow expectation of a token
>> +        * flag in flags and if provided in flags, setup a token at the base.
>> +        */
>> +
>> +       /* If there isn't space for a token */
>> +       if (set_tok && size < SHSTK_ENTRY_SIZE)
>> +               return -ENOSPC;
>> +
>> +       if (addr && (addr & (PAGE_SIZE - 1)))
>> +               return -EINVAL;
>> +
>> +       aligned_size = PAGE_ALIGN(size);
>> +       if (aligned_size < size)
>> +               return -EOVERFLOW;
>> +
>> +       return allocate_shadow_stack(addr, aligned_size, size, set_tok);
>> +}
>>
>> --
>> 2.34.1
>>

