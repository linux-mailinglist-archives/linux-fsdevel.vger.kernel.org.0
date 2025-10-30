Return-Path: <linux-fsdevel+bounces-66469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF00C20328
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 14:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 202E34E6D08
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 13:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8917028643C;
	Thu, 30 Oct 2025 13:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJxopZEf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C475E155333
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 13:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761830373; cv=none; b=Ucdw73fKwShQIkOp9UOdtOkNzx9bqjBvt1JOVjU1X+tTQpBZrocGFZuPj5qI/j3rZXDpnwkT9Q+5MyaKcXoVLM5cCdfuAKnlMngCnc4AJTXK5gG5jOtQdZU8N6jN7q9e4X8YMYy6mOMNk9O1VgrweT6t2q8SxIUvHRQFDOpKSX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761830373; c=relaxed/simple;
	bh=QpAnzb0D2p1ZWhdbDdMUruh1TJSFKgBm/4FWs7HEmWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SuEILiQwc17/nplUWSQQcGtw27aLnkSUYeWJfxA2/SFKr65L6XPSccM6qncykW6q93Zc3TJryJtUzLIL9oi5IN/OpCl+pxG+9JVA/Nsvcw1olm87Bk2CT7VfEDWOtv6zrrljP1FVpjpK5HFAm5scn/vcZw6cYREmeocYTGx6fkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJxopZEf; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-63e0abe71a1so2026851a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 06:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761830368; x=1762435168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgNs3notkwlYCfaZUY2EQYuAlm5MUcJUNJzoQ0kz3gY=;
        b=HJxopZEfJBzg5Wzvr+3imMohWrNsFG/5EMhAvfWix6vDBPhP1SclJqTyQgKI19Fcio
         AK0COK7eydd8R+KsueEcquTGQKM6xcyhBt5lK7Ltq+umJjRbpGbPUhtL1ARNEabHHZ/p
         JEVUAGasOot21dHDwJG6MipEX4pz4v99LM8DAPRjKsrACe6BOzcX3poobyTzaLmcgXMB
         xnAdSYIMnbkXBOwjblzxtefgcOhLASXGxKqlzm1bQnmU6cBziQDZZYnCtJMoksEmnjpg
         58xLoTD9ElOSDdpu/F+Od6zWntSqcvKUBch915JiZX0Pd/A0kxSj+1uTbSXaTlpqwvm6
         AHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761830368; x=1762435168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fgNs3notkwlYCfaZUY2EQYuAlm5MUcJUNJzoQ0kz3gY=;
        b=fxBVpFtqiWoKxOWZhzgN2pTgUD/RyMQn9iq2TGSwI1yyztLT6L7wsK4Yym05j2kbjv
         EfwbokC8uGPEpFynGMBLYW7tSPuI1TJFSVI++crICaVz5OF7KlYheZsgwXQpPqv/jzr+
         zMXcikqGEWGyyExnkxz5usnxsL4yDFIFtpzQ1AImNPMArftpMEL8lVujouJO0I+IqT8t
         0YrON5ozjbBhSIzln28ROmaKoJthOY/IPLkWmnEqmdiYal+bLgSwDh0HqaiVIrKXy2G6
         K4k5r3Q6yS35zJPTEaKmSX+vvtU61KyPSw5Cj0C9140MBKeVm8deZnh/92WwxnTU9XoT
         q2cw==
X-Forwarded-Encrypted: i=1; AJvYcCWdbcjFPmXAqmsrDju0BgDTgNnxRFDr1k9EeSlnqrw0mf8PmkBKUn9/bZe2gSThXQPy9oybc3k/UppjA4iA@vger.kernel.org
X-Gm-Message-State: AOJu0YydYIjcD2Zdbpvh6J2P9e5LLptIPGMXPUQ5NhRZIYwHBp2D/gLk
	4EVASZx6UX72UXPAqSdG/3UkEULiQV/U7wIwdwXsB7fYcMSNxD/ORFdxS6LcAXyt1or85ud4Tqz
	9SAfjQB0551CcUsNzjeTOtqwQxyaALjY=
X-Gm-Gg: ASbGncsovMAXgmOvDM+uDXy8XOERqb+ITrOdDbzN2SmhDuQMwokyf+IAkAUR/fG2oQd
	4vzBsobdRSjFIObJj53Q/cfDhGHrjT13BFcJdoNyxtNtg4hlh3P5h3nas4Q9UHJ3hJMFvXDIWZY
	t/HpEFKtW6ZopieN/IGhBVdgOc0rfQUAJz76KykgMmzpUpZNkuq3bTlm1bXxMnpAxmwyGEGdXaP
	HAxRxUXttzj85hAoPdsJwVgtBxwGoIBhuddW09BHeFyIlJXsIDXV5VlyT0/xwWCcIOs4XClvlww
	R1JNnNCqygEczYg=
X-Google-Smtp-Source: AGHT+IF361R/WAIc8VaDoqQKEUE4CN89kxMMfDi3qcLlX+kAOLMSEQ9qnoXacZXoN+2vKDf2CaGc73KqhA41q7SeDCo=
X-Received: by 2002:a05:6402:5190:b0:634:b7a2:3eaf with SMTP id
 4fb4d7f45d1cf-640442520c3mr6055524a12.18.1761830367848; Thu, 30 Oct 2025
 06:19:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030105242.801528-1-mjguzik@gmail.com> <202510302004.OdLRz1Wy-lkp@intel.com>
In-Reply-To: <202510302004.OdLRz1Wy-lkp@intel.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 30 Oct 2025 14:19:15 +0100
X-Gm-Features: AWmQ_bmaKWvJPGMNKaZCzAmtObzJjTdnoe9rbiYXJSLj7hTzf1ubwz2J_gkLKmg
Message-ID: <CAGudoHGORCV7Gx5Yj+32eU7k4=yu_hjbtS3+PPJ7AtQGxCcqpQ@mail.gmail.com>
Subject: Re: [PATCH v4] fs: hide names_cachep behind runtime access machinery
To: kernel test robot <lkp@intel.com>
Cc: brauner@kernel.org, oe-kbuild-all@lists.linux.dev, viro@zeniv.linux.org.uk, 
	jack@suse.cz, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	torvalds@linux-foundation.org, pfalcato@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm not sending a v5. If you guys are fine with the patch I'm going to
fix up whatever other fallout later.

On Thu, Oct 30, 2025 at 2:14=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Mateusz,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on arnd-asm-generic/master]
> [also build test ERROR on linus/master brauner-vfs/vfs.all linux/master v=
6.18-rc3 next-20251030]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Mateusz-Guzik/fs-h=
ide-names_cachep-behind-runtime-access-machinery/20251030-185523
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.=
git master
> patch link:    https://lore.kernel.org/r/20251030105242.801528-1-mjguzik%=
40gmail.com
> patch subject: [PATCH v4] fs: hide names_cachep behind runtime access mac=
hinery
> config: riscv-allnoconfig (https://download.01.org/0day-ci/archive/202510=
30/202510302004.OdLRz1Wy-lkp@intel.com/config)
> compiler: riscv64-linux-gcc (GCC) 15.1.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20251030/202510302004.OdLRz1Wy-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202510302004.OdLRz1Wy-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    In file included from arch/riscv/include/asm/runtime-const.h:7,
>                     from include/linux/fs.h:53,
>                     from include/linux/huge_mm.h:7,
>                     from include/linux/mm.h:1016,
>                     from arch/riscv/kernel/asm-offsets.c:8:
>    arch/riscv/include/asm/cacheflush.h: In function 'flush_cache_vmap':
> >> arch/riscv/include/asm/cacheflush.h:49:13: error: implicit declaration=
 of function 'is_vmalloc_or_module_addr' [-Wimplicit-function-declaration]
>       49 |         if (is_vmalloc_or_module_addr((void *)start)) {
>          |             ^~~~~~~~~~~~~~~~~~~~~~~~~
>    In file included from include/linux/compat.h:18,
>                     from arch/riscv/include/asm/elf.h:12,
>                     from include/linux/elf.h:6,
>                     from include/linux/module.h:20,
>                     from include/linux/device/driver.h:21,
>                     from include/linux/device.h:32,
>                     from include/linux/node.h:18,
>                     from include/linux/memory.h:19,
>                     from arch/riscv/include/asm/runtime-const.h:9:
>    include/uapi/linux/aio_abi.h: At top level:
> >> include/uapi/linux/aio_abi.h:79:9: error: unknown type name '__kernel_=
rwf_t'; did you mean '__kernel_off_t'?
>       79 |         __kernel_rwf_t aio_rw_flags;    /* RWF_* flags */
>          |         ^~~~~~~~~~~~~~
>          |         __kernel_off_t
>    make[3]: *** [scripts/Makefile.build:182: arch/riscv/kernel/asm-offset=
s.s] Error 1
>    make[3]: Target 'prepare' not remade because of errors.
>    make[2]: *** [Makefile:1282: prepare0] Error 2
>    make[2]: Target 'prepare' not remade because of errors.
>    make[1]: *** [Makefile:248: __sub-make] Error 2
>    make[1]: Target 'prepare' not remade because of errors.
>    make: *** [Makefile:248: __sub-make] Error 2
>    make: Target 'prepare' not remade because of errors.
>
>
> vim +/is_vmalloc_or_module_addr +49 arch/riscv/include/asm/cacheflush.h
>
> 08f051eda33b51 Andrew Waterman 2017-10-25  42
> 7e3811521dc393 Alexandre Ghiti 2023-07-25  43  #ifdef CONFIG_64BIT
> 503638e0babf36 Alexandre Ghiti 2024-07-17  44  extern u64 new_vmalloc[NR_=
CPUS / sizeof(u64) + 1];
> 503638e0babf36 Alexandre Ghiti 2024-07-17  45  extern char _end[];
> 503638e0babf36 Alexandre Ghiti 2024-07-17  46  #define flush_cache_vmap f=
lush_cache_vmap
> 503638e0babf36 Alexandre Ghiti 2024-07-17  47  static inline void flush_c=
ache_vmap(unsigned long start, unsigned long end)
> 503638e0babf36 Alexandre Ghiti 2024-07-17  48  {
> 503638e0babf36 Alexandre Ghiti 2024-07-17 @49   if (is_vmalloc_or_module_=
addr((void *)start)) {
> 503638e0babf36 Alexandre Ghiti 2024-07-17  50           int i;
> 503638e0babf36 Alexandre Ghiti 2024-07-17  51
> 503638e0babf36 Alexandre Ghiti 2024-07-17  52           /*
> 503638e0babf36 Alexandre Ghiti 2024-07-17  53            * We don't care =
if concurrently a cpu resets this value since
> 503638e0babf36 Alexandre Ghiti 2024-07-17  54            * the only place=
 this can happen is in handle_exception() where
> 503638e0babf36 Alexandre Ghiti 2024-07-17  55            * an sfence.vma =
is emitted.
> 503638e0babf36 Alexandre Ghiti 2024-07-17  56            */
> 503638e0babf36 Alexandre Ghiti 2024-07-17  57           for (i =3D 0; i <=
 ARRAY_SIZE(new_vmalloc); ++i)
> 503638e0babf36 Alexandre Ghiti 2024-07-17  58                   new_vmall=
oc[i] =3D -1ULL;
> 503638e0babf36 Alexandre Ghiti 2024-07-17  59   }
> 503638e0babf36 Alexandre Ghiti 2024-07-17  60  }
> 7a92fc8b4d2068 Alexandre Ghiti 2023-12-12  61  #define flush_cache_vmap_e=
arly(start, end)       local_flush_tlb_kernel_range(start, end)
> 7e3811521dc393 Alexandre Ghiti 2023-07-25  62  #endif
> 7e3811521dc393 Alexandre Ghiti 2023-07-25  63
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

