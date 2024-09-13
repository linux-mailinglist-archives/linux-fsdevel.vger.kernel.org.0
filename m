Return-Path: <linux-fsdevel+bounces-29341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC29978527
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 17:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE489283979
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 15:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB516F2E2;
	Fri, 13 Sep 2024 15:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSnZEqbf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A2B2EB02;
	Fri, 13 Sep 2024 15:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726242672; cv=none; b=ZD8tsaWok+Mv3iWiGuyMiFOujPLElB0tXbVXl9V5MkUsvQQ0WkQgk4ZkLRR3Dre7GrT+4qEi2+d+AsPPEczmoHXSZhyjJ1PM8AJO0gpfYkPc3fdqrFnl5RUgYd0QDPmaDBFbAaGDgo/bOPsf7GeEYwgHAqX9apSKa6qlsP5xeZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726242672; c=relaxed/simple;
	bh=ecz4eJEVPDt26YmFuv0POtj0jecJSvSuFAGuu1dxlPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lw/QD0HiBcoYfZJs8/hWFb/fMcMVUebqHRkw1vYVg7T3txSRQImy89sAWAOYimQRe6S7pG9azp6458Jua/GtiyVMwaWaZKWScnR4kmQidW1vhR5XfJMoAJAzkJShqTjvV3WHhC+oEZucjKfkM3adABg7GoX77CYcYAweIgCm2bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSnZEqbf; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-277cfd3f07aso1038165fac.3;
        Fri, 13 Sep 2024 08:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726242670; x=1726847470; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ehs9yLbkVlOBEgkAu8IxC2ecxN3bEC7UNanNZJEoFLs=;
        b=ZSnZEqbfrsKroStwuSqiYqz5TPdo8h9torfCDIwj+Z1sfF9ZjJAYvGLa/Yq+LfYw5n
         9YoTLFa1FrjXGfbznkXST5UoHom9ykmhXDn0NQ8ZG6lQUdkchiY7hf6GRmXnzTD1/3Cs
         knjqpWRuM8wxrAIBHwkyQcsWjAls9reT6hDtU/mO+wpt/+VYsePJZPwO3oLbxSvHeUSl
         RahBPIcH5x4Zq30P4x6CKErjVpW7hn/b0qTgxWAWrRo/hxdGfPqy2FfjbohMMZHQ9Bdr
         mHw/inct6gmUqMljmmoUh5WM4ghh9Fj87ZZ9I64Ix85GAYU43ijdYyPXTOfDr8YuHC/X
         Lk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726242670; x=1726847470;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ehs9yLbkVlOBEgkAu8IxC2ecxN3bEC7UNanNZJEoFLs=;
        b=TyYhK24END3FFGMCIRvfDBTkIuG4YyINv7xv6vUIwEFTQGEUxrjdpowog1vmSfE22P
         H2gxTug/ITPggqygH477AgtAUCPdcDf+BOzVmd05w5AMf2d3eljGgXWOjQEMA4p5zKVx
         4xb6dA7h2/muSAFDArIJiQOTUvpi0oYjaOOJWL1chahQpSvWCehR7JrIkB8nta+R1i73
         496MJdux/VyRxEzYAGwb6cTctktSLcc7yhstiShMhCpr88CSxD9NkfQ0m48Fv+v7hJn5
         7UIihCoMJ3kAVcH76oGAz73zUbd17E2UgAvgI6pctojmamzadou82NlO8l5uoW57kuGs
         4Fkg==
X-Forwarded-Encrypted: i=1; AJvYcCUTwpmJB64/HCIJ+1xNP5wjZc5UM4I7+AlBqu/+jZa6E8GB+zDmGKfwx9H3lo1/Cx10BpGGeUJGF5oq@vger.kernel.org, AJvYcCUcLPCEi1BOFK1LIqn0KF+YyFR2dOT5kbX0WcBVba1PKldkht8W1GuSEfUzmkBfeP7gLpOTIku+PbN+tqtt@vger.kernel.org, AJvYcCUfv3VH0N7KiarGtYPITjZnWZBiRLpnQ2n3ZrxlyRW5//c09gbWyJSKfwbv79uN7lhwFRjv7h1pkjlTRg==@vger.kernel.org, AJvYcCV5DtwEPDWFMtAwPKSmz804u6jXcwBCrpWI6hz4NkU2y7UYEGF0olO4eTYyhTus9ONCVNB6+wFSHIce@vger.kernel.org, AJvYcCW571Lk7l6h9rfhktMmfOBonDcaqacZfAz9s3Tle3/qCZ4sYOVhAtwbUgKgqwzLfpXdMzp5tDXmp+6p/4nEJufq@vger.kernel.org, AJvYcCXDJDCPxGmrJwvLd19BQxIWQb03CKpQ5jz/twNmol8+rTTYx6L9+VxtQU0LySLjQwTzHLmx9NxzTUmGwdLStQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwK/w07WkEaNhHiAYtURq8sJWDbUYY18b06ocnwUgRMcnfwpTWl
	cnQ3qJCFSc5/QAw86FNK/2cfUFyfiA3Azw88g9vLTTfrMkGtLBuH
X-Google-Smtp-Source: AGHT+IGwspwIdcxizms74BUEV11s0x25xQw3otEtykkXT6P5qLAwtjFU5Aef8TBprXa84EXBrlG8AA==
X-Received: by 2002:a05:6870:df92:b0:27c:475c:ab2c with SMTP id 586e51a60fabf-27c475cad93mr3175704fac.43.1726242670341;
        Fri, 13 Sep 2024 08:51:10 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:dff5:4180:2562:4c1e? ([2603:8080:7400:36da:dff5:4180:2562:4c1e])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-27ba40b0bb0sm3632948fac.41.2024.09.13.08.51.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 08:51:09 -0700 (PDT)
Message-ID: <5cc36aa7-e064-42b3-b52e-fb471d99d338@gmail.com>
Date: Fri, 13 Sep 2024 10:51:04 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/30] mm: Introduce ARCH_HAS_USER_SHADOW_STACK
To: Deepak Gupta <debug@rivosinc.com>, paul.walmsley@sifive.com,
 palmer@sifive.com, conor@kernel.org, linux-doc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: corbet@lwn.net, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 robh@kernel.org, krzk+dt@kernel.org, oleg@redhat.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, peterz@infradead.org, akpm@linux-foundation.org,
 arnd@arndb.de, ebiederm@xmission.com, kees@kernel.org,
 Liam.Howlett@oracle.com, vbabka@suse.cz, lorenzo.stoakes@oracle.com,
 shuah@kernel.org, brauner@kernel.org, samuel.holland@sifive.com,
 andy.chiu@sifive.com, jerry.shih@sifive.com, greentime.hu@sifive.com,
 charlie@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com,
 xiao.w.wang@intel.com, ajones@ventanamicro.com, anup@brainfault.org,
 mchitale@ventanamicro.com, atishp@rivosinc.com, sameo@rivosinc.com,
 bjorn@rivosinc.com, alexghiti@rivosinc.com, david@redhat.com,
 libang.li@antgroup.com, jszhang@kernel.org, leobras@redhat.com,
 guoren@kernel.org, samitolvanen@google.com, songshuaishuai@tinylab.org,
 costa.shul@redhat.com, bhe@redhat.com, zong.li@sifive.com,
 puranjay@kernel.org, namcaov@gmail.com, antonb@tenstorrent.com,
 sorear@fastmail.com, quic_bjorande@quicinc.com, ancientmodern4@gmail.com,
 ben.dooks@codethink.co.uk, quic_zhonhan@quicinc.com,
 cuiyunhui@bytedance.com, yang.lee@linux.alibaba.com, ke.zhao@shingroup.cn,
 sunilvl@ventanamicro.com, tanzhasanwork@gmail.com, schwab@suse.de,
 dawei.li@shingroup.cn, rppt@kernel.org, willy@infradead.org,
 usama.anjum@collabora.com, osalvador@suse.de, ryan.roberts@arm.com,
 andrii@kernel.org, alx@kernel.org, catalin.marinas@arm.com,
 broonie@kernel.org, revest@chromium.org, bgray@linux.ibm.com, deller@gmx.de,
 zev@bewilderbeest.net, Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20240912231650.3740732-1-debug@rivosinc.com>
 <20240912231650.3740732-2-debug@rivosinc.com>
Content-Language: en-US
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
In-Reply-To: <20240912231650.3740732-2-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/24 18:16, Deepak Gupta wrote:

> From: Mark Brown <broonie@kernel.org>
>
> Since multiple architectures have support for shadow stacks and we need to
> select support for this feature in several places in the generic code
> provide a generic config option that the architectures can select.
>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Reviewed-by: Deepak Gupta <debug@rivosinc.com>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  arch/x86/Kconfig   | 1 +
>  fs/proc/task_mmu.c | 2 +-
>  include/linux/mm.h | 2 +-
>  mm/Kconfig         | 6 ++++++
>  4 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 007bab9f2a0e..320e1f411163 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1957,6 +1957,7 @@ config X86_USER_SHADOW_STACK
>  	depends on AS_WRUSS
>  	depends on X86_64
>  	select ARCH_USES_HIGH_VMA_FLAGS
> +	select ARCH_HAS_USER_SHADOW_STACK
>  	select X86_CET
>  	help
>  	  Shadow stack protection is a hardware feature that detects function
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 5f171ad7b436..0ea49725f524 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -984,7 +984,7 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
>  #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
>  		[ilog2(VM_UFFD_MINOR)]	= "ui",
>  #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
> -#ifdef CONFIG_X86_USER_SHADOW_STACK
> +#ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK
>  		[ilog2(VM_SHADOW_STACK)] = "ss",
>  #endif
>  #ifdef CONFIG_64BIT
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 147073601716..e39796ea17db 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -346,7 +346,7 @@ extern unsigned int kobjsize(const void *objp);
>  #endif
>  #endif /* CONFIG_ARCH_HAS_PKEYS */
>  
> -#ifdef CONFIG_X86_USER_SHADOW_STACK
> +#ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK
>  /*
>   * VM_SHADOW_STACK should not be set with VM_SHARED because of lack of
>   * support core mm.
> diff --git a/mm/Kconfig b/mm/Kconfig
> index b72e7d040f78..3167be663bca 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1263,6 +1263,12 @@ config IOMMU_MM_DATA
>  config EXECMEM
>  	bool
>  
> +config ARCH_HAS_USER_SHADOW_STACK
> +	bool
> +	help
> +	  The architecture has hardware support for userspace shadow call
> +          stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
> +
>  source "mm/damon/Kconfig"


Reviewed-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>


>  
>  endmenu


Thanks, Carlos


