Return-Path: <linux-fsdevel+bounces-44011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AA5A60B96
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 09:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D0663BF021
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 08:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E661D63C3;
	Fri, 14 Mar 2025 08:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="NU/YSRaN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8031C8603
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 08:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741941017; cv=none; b=H83gQl8itSmRreXOgymrK3ncYwMNSY9h0Xc45h99F043iAnonv/18sJG0ojWu0OAkXmoBmMrP625UPuwiM1m4bnnvJzzdBq1Z2JLcFJBuf8sgUu5PABiehJ02iKbbEfTRpv1lJCbRp8vrrGY04iMQDFH2jJXiun4/NRCXoArcxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741941017; c=relaxed/simple;
	bh=iSIhq3LXJ9vjpKk5E/iPbxxLotC2yhDeKz1HWMSgJfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nRmPuOSN520YBPO48ILjtSzqg/ltTsnA+EKDL776uOUoYbmfUvcZwQ2aj4fOEOZnQCaU+RGlc5NdP23GAxxYWlhQ57+eXhMQ9Hf56z1hSN4wYVBPpppnYmkYMue/4GqWD4uhfYom2QHi7yLmwDx4G78KhsEWsxIKC/0AgGWJxCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=NU/YSRaN; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-85dac9728cdso52915839f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 01:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1741941013; x=1742545813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHQAFT19Zq6akViEkHfz6Mh4tV3mef9iqXwpMSCN/RQ=;
        b=NU/YSRaNgA7ur4WCNfkdExywdRb8HGqURYrfoL8fbDVUNvu+twha03V6PxUbgKo+Oi
         uuDB77A8Y9X1VlB1bPlTVSiHqbEsoLvfCei8aGevEunx2HO21GSUGM2G6iFhzNySvDL5
         zz43MCzshhfrQS1Pc2UC8Acnyf6hUE8zyxc0+xbF2Lmss+ztZiZRvjE30ci3agYwoepl
         Da6UwOgMSoi46huNES/2WnDrji9XeysHjaMt/7wWdza4QmPoSEb+JNITJP/H7/C9ctjH
         w9kC/ojmjsEJ/w2IrfJOB32Yrh71zBG37jpsG5I4o7pbJcXEpQr+3Y1/hhrGrwQ5XEj4
         JXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741941013; x=1742545813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHQAFT19Zq6akViEkHfz6Mh4tV3mef9iqXwpMSCN/RQ=;
        b=woR3Io8zIM/bazgUvpKz2Mb6XuSQxVujajMRzO3u/clWKEsNLsid7EN9zMBh9ljbtm
         48X8Ng/tNND5gYT6GBFUelCqpkd02MqYCu15JOVjqLndesUWX+8glF3zxgCOgM+u67ds
         LHCeUmmE+OvhmLeO2fKWuGqba3DMUX6mUCH9efnm0HIIVe8bX9kucf+Yqv5Tstf+tZs4
         QHTpSEQAI/sw//lMso3cW+Og7O8XstFIvRkryZjGnFmKY/5Af4bg0DNPLFmBRiO6F/iO
         go9gHlzbq9xleTCuXiedcE8vvAXBpHrHF8ikw4dM/eg3aepQ7c9IqD3Y8IgT6h8Tj8r4
         Q1NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBvGa9CBG7lVuDzabJDjNbPMWGa4jAcGNZqMKNoN0sbD+GtTOuSzS/ZkigpvkZ3nx2l/hdGhtlmiMYRrF7@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8TAvhkWWnbQHof4jw9b3q8O9F7rUQUg9rehcO/JNF/3ot4KIL
	J3IG4z2XFjAtjw9rFzjFxYgJ8UtzjcbavAE/yD5vl1Wd5jO0/vjL9dakL6XpKNSNS+Df2nFnCHk
	aDoVSYeAGYLf3MLfzkUosgDnbqDuF7VI4OXzsFA==
X-Gm-Gg: ASbGncuzsmVLtmUdd8WHm7Uid9uLhiIgy9Eo/8WiLNUqCT4xzXzLoIFQ5Jt/x33QDU5
	XPKQrfTdPhN4jsewfCGRarrYJGOCA1f/CtdrekKVqr8OuJIlIc18s7Zx1E/1byUvMwmOvvZiebb
	IrQlyBl1BuVEJoz3khHAmp4wBLbUxkNJNwCYkEZA==
X-Google-Smtp-Source: AGHT+IEQZBAAWQBzkkxA4UVWoIwfMxv3lOX1yAW82xZYAmzoSJt5ME/GJlXO4+fh8gCNW8gq2XMNfQJFOUPdwSXIT8w=
X-Received: by 2002:a05:6602:4a03:b0:85b:4484:182c with SMTP id
 ca18e2360f4ac-85dc4885acbmr152534039f.11.1741941013056; Fri, 14 Mar 2025
 01:30:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310-v5_user_cfi_series-v11-0-86b36cbfb910@rivosinc.com> <20250310-v5_user_cfi_series-v11-10-86b36cbfb910@rivosinc.com>
In-Reply-To: <20250310-v5_user_cfi_series-v11-10-86b36cbfb910@rivosinc.com>
From: Zong Li <zong.li@sifive.com>
Date: Fri, 14 Mar 2025 16:30:02 +0800
X-Gm-Features: AQ5f1JoD01TEQdI5WTe4PSnTnl_zETty75cDetOqvifwsUixI3qGOMOegGkUt3E
Message-ID: <CANXhq0pqoCZXhjMx7DwO6Yc8TMEbG1XE2PUEeF_pOsj8yxLdMQ@mail.gmail.com>
Subject: Re: [PATCH v11 10/27] riscv/mm: Implement map_shadow_stack() syscall
To: Deepak Gupta <debug@rivosinc.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, Jann Horn <jannh@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com, 
	richard.henderson@linaro.org, jim.shu@sifive.com, andybnac@gmail.com, 
	kito.cheng@sifive.com, charlie@rivosinc.com, atishp@rivosinc.com, 
	evan@rivosinc.com, cleger@rivosinc.com, alexghiti@rivosinc.com, 
	samitolvanen@google.com, broonie@kernel.org, rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 11:42=E2=80=AFPM Deepak Gupta <debug@rivosinc.com> =
wrote:
>
> As discussed extensively in the changelog for the addition of this
> syscall on x86 ("x86/shstk: Introduce map_shadow_stack syscall") the
> existing mmap() and madvise() syscalls do not map entirely well onto the
> security requirements for shadow stack memory since they lead to windows
> where memory is allocated but not yet protected or stacks which are not
> properly and safely initialised. Instead a new syscall map_shadow_stack()
> has been defined which allocates and initialises a shadow stack page.
>
> This patch implements this syscall for riscv. riscv doesn't require token
> to be setup by kernel because user mode can do that by itself. However to
> provide compatibility and portability with other architectues, user mode
> can specify token set flag.
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  arch/riscv/kernel/Makefile  |   1 +
>  arch/riscv/kernel/usercfi.c | 144 ++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 145 insertions(+)
>
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 8d186bfced45..3a861d320654 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -125,3 +125,4 @@ obj-$(CONFIG_ACPI)          +=3D acpi.o
>  obj-$(CONFIG_ACPI_NUMA)        +=3D acpi_numa.o
>
>  obj-$(CONFIG_GENERIC_CPU_VULNERABILITIES) +=3D bugs.o
> +obj-$(CONFIG_RISCV_USER_CFI) +=3D usercfi.o
> diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
> new file mode 100644
> index 000000000000..24022809a7b5
> --- /dev/null
> +++ b/arch/riscv/kernel/usercfi.c
> @@ -0,0 +1,144 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 Rivos, Inc.
> + * Deepak Gupta <debug@rivosinc.com>
> + */
> +
> +#include <linux/sched.h>
> +#include <linux/bitops.h>
> +#include <linux/types.h>
> +#include <linux/mm.h>
> +#include <linux/mman.h>
> +#include <linux/uaccess.h>
> +#include <linux/sizes.h>
> +#include <linux/user.h>
> +#include <linux/syscalls.h>
> +#include <linux/prctl.h>
> +#include <asm/csr.h>
> +#include <asm/usercfi.h>
> +
> +#define SHSTK_ENTRY_SIZE sizeof(void *)
> +
> +/*
> + * Writes on shadow stack can either be `sspush` or `ssamoswap`. `sspush=
` can happen
> + * implicitly on current shadow stack pointed to by CSR_SSP. `ssamoswap`=
 takes pointer to
> + * shadow stack. To keep it simple, we plan to use `ssamoswap` to perfor=
m writes on shadow
> + * stack.
> + */
> +static noinline unsigned long amo_user_shstk(unsigned long *addr, unsign=
ed long val)
> +{
> +       /*
> +        * Never expect -1 on shadow stack. Expect return addresses and z=
ero
> +        */
> +       unsigned long swap =3D -1;
> +
> +       __enable_user_access();
> +       asm goto(
> +               ".option push\n"
> +               ".option arch, +zicfiss\n"
> +               "1: ssamoswap.d %[swap], %[val], %[addr]\n"
> +               _ASM_EXTABLE(1b, %l[fault])
> +               RISCV_ACQUIRE_BARRIER
> +               ".option pop\n"
> +               : [swap] "=3Dr" (swap), [addr] "+A" (*addr)
> +               : [val] "r" (val)
> +               : "memory"
> +               : fault
> +               );
> +       __disable_user_access();
> +       return swap;
> +fault:
> +       __disable_user_access();
> +       return -1;
> +}
> +
> +/*
> + * Create a restore token on the shadow stack.  A token is always XLEN w=
ide
> + * and aligned to XLEN.
> + */
> +static int create_rstor_token(unsigned long ssp, unsigned long *token_ad=
dr)
> +{
> +       unsigned long addr;
> +
> +       /* Token must be aligned */
> +       if (!IS_ALIGNED(ssp, SHSTK_ENTRY_SIZE))
> +               return -EINVAL;
> +
> +       /* On RISC-V we're constructing token to be function of address i=
tself */
> +       addr =3D ssp - SHSTK_ENTRY_SIZE;
> +
> +       if (amo_user_shstk((unsigned long __user *)addr, (unsigned long)s=
sp) =3D=3D -1)
> +               return -EFAULT;
> +
> +       if (token_addr)
> +               *token_addr =3D addr;
> +
> +       return 0;
> +}
> +
> +static unsigned long allocate_shadow_stack(unsigned long addr, unsigned =
long size,
> +                                          unsigned long token_offset, bo=
ol set_tok)
> +{
> +       int flags =3D MAP_ANONYMOUS | MAP_PRIVATE;
> +       struct mm_struct *mm =3D current->mm;
> +       unsigned long populate, tok_loc =3D 0;
> +
> +       if (addr)
> +               flags |=3D MAP_FIXED_NOREPLACE;
> +
> +       mmap_write_lock(mm);
> +       addr =3D do_mmap(NULL, addr, size, PROT_READ, flags,
> +                      VM_SHADOW_STACK | VM_WRITE, 0, &populate, NULL);
> +       mmap_write_unlock(mm);
> +
> +       if (!set_tok || IS_ERR_VALUE(addr))
> +               goto out;
> +
> +       if (create_rstor_token(addr + token_offset, &tok_loc)) {
> +               vm_munmap(addr, size);
> +               return -EINVAL;
> +       }
> +
> +       addr =3D tok_loc;
> +
> +out:
> +       return addr;
> +}
> +
> +SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, si=
ze, unsigned int, flags)
> +{
> +       bool set_tok =3D flags & SHADOW_STACK_SET_TOKEN;
> +       unsigned long aligned_size =3D 0;
> +
> +       if (!cpu_supports_shadow_stack())
> +               return -EOPNOTSUPP;
> +
> +       /* Anything other than set token should result in invalid param *=
/
> +       if (flags & ~SHADOW_STACK_SET_TOKEN)
> +               return -EINVAL;
> +
> +       /*
> +        * Unlike other architectures, on RISC-V, SSP pointer is held in =
CSR_SSP and is available
> +        * CSR in all modes. CSR accesses are performed using 12bit index=
 programmed in instruction
> +        * itself. This provides static property on register programming =
and writes to CSR can't
> +        * be unintentional from programmer's perspective. As long as pro=
grammer has guarded areas
> +        * which perform writes to CSR_SSP properly, shadow stack pivotin=
g is not possible. Since
> +        * CSR_SSP is writeable by user mode, it itself can setup a shado=
w stack token subsequent
> +        * to allocation. Although in order to provide portablity with ot=
her architecture (because
> +        * `map_shadow_stack` is arch agnostic syscall), RISC-V will foll=
ow expectation of a token
> +        * flag in flags and if provided in flags, setup a token at the b=
ase.
> +        */
> +
> +       /* If there isn't space for a token */
> +       if (set_tok && size < SHSTK_ENTRY_SIZE)
> +               return -ENOSPC;
> +
> +       if (addr && (addr & (PAGE_SIZE - 1)))
> +               return -EINVAL;
> +
> +       aligned_size =3D PAGE_ALIGN(size);
> +       if (aligned_size < size)
> +               return -EOVERFLOW;
> +
> +       return allocate_shadow_stack(addr, aligned_size, size, set_tok);
> +}
>
LGTM.

Reviewed-by: Zong Li <zong.li@sifive.com>
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

