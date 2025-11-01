Return-Path: <linux-fsdevel+bounces-66663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BCAC27CA4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 01 Nov 2025 12:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C2461A21BBB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Nov 2025 11:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2192F3612;
	Sat,  1 Nov 2025 11:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2lHGrph"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427DF2D46BB
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Nov 2025 11:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761996370; cv=none; b=sxsFsCt5GqPL8IZ4BIABy2v49i3WIK3izEb90Huba69IH813N8Vzwo62NXrSVle674VOuS1RvFUXnL9VVb8Hhzm8DdEx5GW45JwtQipfpGDLku2ZSounaMvZ856/t7lv/7FEzbrYECn5znaX2t+VXIVRFkJ42T1CmFAfGWT2Qto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761996370; c=relaxed/simple;
	bh=P6U9jSxQzSxAMuDBWU6Hr8PbQHnhvGY7+raQ3YD7YEA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hd4W5FSfWcQsl8bzYVmkNx7izqOb4fSOSRySJ96DoiA88OI+BaIDXvaIY6CEqPQDaZ0LoB95ap/d2ZoaNEMrgFkxmx2BCU2Lg5IGicUJP3DlHFhvFFLEcfGlAYaiGl5nuzoThtxdA89xVd/UNBUOq/3aN8rCkmwmjlSROXjBylY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2lHGrph; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-475ca9237c2so16541735e9.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Nov 2025 04:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761996366; x=1762601166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=apQHIdVHxDKUXTs9N4QKJgNs7mj7CIkDdRkworlkT+M=;
        b=k2lHGrphrA6tbQI0Ae7Ym5Kw66hfcmhksAMDx0zcZIoU+8dGj9ewU+u0oF29+fIxLP
         xuEM6fXhcma4DX83Gt+yHassC/6e5QpmR5r9q+2yHOuuyfkOvXPYP3q4n3HVEhM/xRHB
         diG0yhLydZTJZR8bKhbpIVnTlBl18Mn/cprzDjy+YNIhEZSJ60tVIhsCAmFcNHZlhM0A
         51a6sB1vZU+n0bZgIfFmAJi+GoBcjm0WbxdvYCBFNERTGNjL4193eroPa9pvSsCx7mR8
         +YJ7A4BgJEYXovtUQ1khRhf6qfDtHkPRJfC49r0QDne/fvDSSiecrNtSZY1LN2b2WxrH
         VwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761996366; x=1762601166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=apQHIdVHxDKUXTs9N4QKJgNs7mj7CIkDdRkworlkT+M=;
        b=hjn+Fd2RMx6AwAeBD6Q0HyQOL41RtBbgm5lyei8bW7kOWwWp0hidEAa26nWDRzsYBC
         pZF0s3uR3RFDxSHsilxotfI4liJWL0TwGGKgQdzrVTOHFJmC/rf/LCFyXadch9bwrhj4
         kj4eYyuap8GV7kYXD4ljaCJSdPJBvpWoHqUBGyS5397E6sI4cSQBLivFDOQXvZuTTsgp
         FO4Z3A5dXm9aRg6B3zgvGTQk8Ubk66RKVQ8XcdXYGU2MKsjfrjg+FvlVxz1ngeaC8Hk8
         YZAimfLnr/faj4YzyHaI+fKQbXDtcUFj+eDZeTkHSdk9pq/Li0tFYgynx25ZJGvHJMJw
         EK/w==
X-Forwarded-Encrypted: i=1; AJvYcCWzpt5mxHOf4NULe298X3bJ17wq0zuDmv+ZsMWQJTaDQuD6S/Wj6536iOHdsfSASLNK9vC2S+v2NHu82eir@vger.kernel.org
X-Gm-Message-State: AOJu0YynF4ivoGMUBYLOurspvAlhO51n9d4kyF6OunHZSA8pr599E8Ft
	I9uAw/BOfogvlIEQ9XIGKP+z3wYeMW1rLBLF9aV0BBDc64SwMYaPa0LD
X-Gm-Gg: ASbGncvtml99OwxC2O7wKIhmaduQurrNL9qbq4PIpzGITDKlYFQbogH5l963rJwn26w
	Donx3cJL6rF1wX4ADQYDYks16JQuKkDvP+WrRSyqsIQAWDaUt2HmR+nlJuU87V/+fapK2UzeYXp
	aa4gwmIAE4idTvC/+nDMZ+9JIJJCskY8D9Y7WF3MWndzXkJTlyKtrp9VEmS+oj0hpwSXqFVDcvc
	kNu0gs0wn8SB/Y3hCb7h/VBTe9htp1xJT3UHIFJyXzcLunJrkVuaxUOBDmQCg9iADy96OUvgLGZ
	Ju/gun6a0E/EtByaGLVXvxtrwWMsyXalIpxUIn5rKc7bigJb2BAQHXTpzwvdWa2kz13Z2iJpWnH
	6XZ5ubQsGv8k1VlYOydua/AmHk13quLENvMkFRzttbgnEqa6MuEkgxjycxSj8w3geG7+jNIFz+0
	kop33BuGD8GpZGmzMo1PK8nuLhTvJb5JVVM6CcXhVqIQ==
X-Google-Smtp-Source: AGHT+IEr4/HldgWidFLXKjNmN2bl8DUgYLiLVXGnzbSW/gMHZwfUqjsaJPk8BTMHs+j38xWW6TZjNg==
X-Received: by 2002:a05:600c:1e29:b0:46e:1fc2:f9ac with SMTP id 5b1f17b1804b1-477307b8790mr52280285e9.10.1761996366207;
        Sat, 01 Nov 2025 04:26:06 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c2e66f8sm44797165e9.1.2025.11.01.04.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 04:26:05 -0700 (PDT)
Date: Sat, 1 Nov 2025 11:26:04 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: torvalds@linux-foundation.org, brauner@kernel.org,
 viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, tglx@linutronix.de, pfalcato@suse.de
Subject: Re: [PATCH 1/3] x86: fix access_ok() and valid_user_address() using
 wrong USER_PTR_MAX in modules
Message-ID: <20251101112604.09d32993@pumpkin>
In-Reply-To: <20251031174220.43458-2-mjguzik@gmail.com>
References: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
	<20251031174220.43458-1-mjguzik@gmail.com>
	<20251031174220.43458-2-mjguzik@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Oct 2025 18:42:18 +0100
Mateusz Guzik <mjguzik@gmail.com> wrote:

> [real commit message will land here later]

Hmmm... modules use the 0x123456789abcdef0 placeholder (the 0 might not be
in the right place), this is non-canonical so nothing is badly broken.
Just allows speculative accesses to kernel space on some cpu.

> ---
>  arch/x86/include/asm/uaccess_64.h | 17 +++++++++--------
>  arch/x86/kernel/cpu/common.c      |  8 +++++---
>  2 files changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
> index c8a5ae35c871..f60c0ed147c3 100644
> --- a/arch/x86/include/asm/uaccess_64.h
> +++ b/arch/x86/include/asm/uaccess_64.h
> @@ -12,13 +12,14 @@
>  #include <asm/cpufeatures.h>
>  #include <asm/page.h>
>  #include <asm/percpu.h>
> -#include <asm/runtime-const.h>
>  
> -/*
> - * Virtual variable: there's no actual backing store for this,
> - * it can purely be used as 'runtime_const_ptr(USER_PTR_MAX)'
> - */
> -extern unsigned long USER_PTR_MAX;
> +extern unsigned long user_ptr_max;
> +#ifdef MODULE
> +#define __user_ptr_max_accessor	user_ptr_max
> +#else
> +#include <asm/runtime-const.h>
> +#define __user_ptr_max_accessor	runtime_const_ptr(user_ptr_max)
> +#endif
>  
>  #ifdef CONFIG_ADDRESS_MASKING
>  /*
> @@ -54,7 +55,7 @@ static inline unsigned long __untagged_addr_remote(struct mm_struct *mm,
>  #endif
>  
>  #define valid_user_address(x) \
> -	likely((__force unsigned long)(x) <= runtime_const_ptr(USER_PTR_MAX))
> +	likely((__force unsigned long)(x) <= __user_ptr_max_accessor)
>  
>  /*
>   * Masking the user address is an alternative to a conditional
> @@ -67,7 +68,7 @@ static inline void __user *mask_user_address(const void __user *ptr)
>  	asm("cmp %1,%0\n\t"
>  	    "cmova %1,%0"
>  		:"=r" (ret)
> -		:"r" (runtime_const_ptr(USER_PTR_MAX)),
> +		:"r" (__user_ptr_max_accessor),
>  		 "0" (ptr));
>  	return ret;
>  }
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 3ff9682d8bc4..f338f5e9adfc 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -78,6 +78,9 @@
>  DEFINE_PER_CPU_READ_MOSTLY(struct cpuinfo_x86, cpu_info);
>  EXPORT_PER_CPU_SYMBOL(cpu_info);
>  
> +unsigned long user_ptr_max __ro_after_init;
> +EXPORT_SYMBOL(user_ptr_max);

That doesn't appear to be inside a CONFIG_X86_64 define.
I think I'd initialise it to one of its two values - probably the LA48 one.

	David

> +
>  u32 elf_hwcap2 __read_mostly;
>  
>  /* Number of siblings per CPU package */
> @@ -2575,14 +2578,13 @@ void __init arch_cpu_finalize_init(void)
>  	alternative_instructions();
>  
>  	if (IS_ENABLED(CONFIG_X86_64)) {
> -		unsigned long USER_PTR_MAX = TASK_SIZE_MAX;
> -
> +		user_ptr_max = TASK_SIZE_MAX;
>  		/*
>  		 * Enable this when LAM is gated on LASS support
>  		if (cpu_feature_enabled(X86_FEATURE_LAM))
>  			USER_PTR_MAX = (1ul << 63) - PAGE_SIZE;
>  		 */
> -		runtime_const_init(ptr, USER_PTR_MAX);
> +		runtime_const_init(ptr, user_ptr_max);
>  
>  		/*
>  		 * Make sure the first 2MB area is not mapped by huge pages


