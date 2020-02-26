Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3689E170A9B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 22:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbgBZVjy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 16:39:54 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37585 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbgBZVjw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 16:39:52 -0500
Received: by mail-pf1-f193.google.com with SMTP id p14so446295pfn.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2020 13:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SuRPBFQdcJTBQXLfW7zhTZM3AVXzTzaLq0hZO+OJ8t8=;
        b=McMrWJB/rzDG1kYNRHCmu6YGhWogESTULXa4e+VE70LyFgccjXgbd+15VJ3LqXUUU8
         jJaLOjX8fotobjx6twtTRj4EZmpxPNIw/R2SlyBMIKuyHb/AIRdVMvgSR5jzwqx1whrJ
         Fa20+GL6IL88TZFTbMeFNrQ8Xj9oz3fbcCWZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SuRPBFQdcJTBQXLfW7zhTZM3AVXzTzaLq0hZO+OJ8t8=;
        b=mnckgDeBWW43EcHSX9Hwax2Gz/Fbucwb6BiYsSGm3lCa4O8UY4CCSnmQ7CIbz+je1c
         0lP8AtSh4D43dfyLhquA6ABASM1L8z0RLVHZGUrMOxxnZwys5yN7A0UNEuSoctHa7P6g
         xVpWtZODEFNo6eafAI80tMLgLKDcxQtnlU3S/VewBOEmIx5lkSrt0rZjmGLdTBLpHgtq
         qvXhrdE5j0NFKgFwe44ex3f2UkMJAqv8leTCcCkPyQfcPCjlaO3iULXtueMbbbXgEPed
         9RovjcJeHS6wZv6GULy6txUOsW9xbsAne2ZRLXwGF0dj6hkNxr2Obcu1syFZeFvHom4N
         aZdA==
X-Gm-Message-State: APjAAAW1fgdR/GZlejNpW/1BzfOdcfeTDCs6C2leLPfKaY0F6K9GLrr9
        MjkOtT9tuimbbPHU03+x1MuWnw==
X-Google-Smtp-Source: APXvYqywytR40Z7EOffZT448kxzYwWrN/27FUekevyfwSHqRVpegVaIO/Shffbk5jeh0USf/WAeU7Q==
X-Received: by 2002:a63:1a5b:: with SMTP id a27mr769948pgm.249.1582753191171;
        Wed, 26 Feb 2020 13:39:51 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i2sm3730242pjs.21.2020.02.26.13.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 13:39:50 -0800 (PST)
Date:   Wed, 26 Feb 2020 13:39:49 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "H . J . Lu " <hjl.tools@gmail.com>,
        Andrew Jones <drjones@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Weimer <fweimer@redhat.com>,
        Sudakshina Das <sudi.das@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v7 08/11] arm64: traps: Shuffle code to eliminate forward
 declarations
Message-ID: <202002261339.53539BA19@keescook>
References: <20200226155714.43937-1-broonie@kernel.org>
 <20200226155714.43937-9-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226155714.43937-9-broonie@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 26, 2020 at 03:57:11PM +0000, Mark Brown wrote:
> From: Dave Martin <Dave.Martin@arm.com>
> 
> Hoist the IT state handling code earlier in traps.c, to avoid
> accumulating forward declarations.
> 
> No functional change.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/kernel/traps.c | 103 ++++++++++++++++++--------------------
>  1 file changed, 50 insertions(+), 53 deletions(-)
> 
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index bc9f4292bfc3..3c07a7074145 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -272,7 +272,55 @@ void arm64_notify_die(const char *str, struct pt_regs *regs,
>  	}
>  }
>  
> -static void advance_itstate(struct pt_regs *regs);
> +#ifdef CONFIG_COMPAT
> +#define PSTATE_IT_1_0_SHIFT	25
> +#define PSTATE_IT_1_0_MASK	(0x3 << PSTATE_IT_1_0_SHIFT)
> +#define PSTATE_IT_7_2_SHIFT	10
> +#define PSTATE_IT_7_2_MASK	(0x3f << PSTATE_IT_7_2_SHIFT)
> +
> +static u32 compat_get_it_state(struct pt_regs *regs)
> +{
> +	u32 it, pstate = regs->pstate;
> +
> +	it  = (pstate & PSTATE_IT_1_0_MASK) >> PSTATE_IT_1_0_SHIFT;
> +	it |= ((pstate & PSTATE_IT_7_2_MASK) >> PSTATE_IT_7_2_SHIFT) << 2;
> +
> +	return it;
> +}
> +
> +static void compat_set_it_state(struct pt_regs *regs, u32 it)
> +{
> +	u32 pstate_it;
> +
> +	pstate_it  = (it << PSTATE_IT_1_0_SHIFT) & PSTATE_IT_1_0_MASK;
> +	pstate_it |= ((it >> 2) << PSTATE_IT_7_2_SHIFT) & PSTATE_IT_7_2_MASK;
> +
> +	regs->pstate &= ~PSR_AA32_IT_MASK;
> +	regs->pstate |= pstate_it;
> +}
> +
> +static void advance_itstate(struct pt_regs *regs)
> +{
> +	u32 it;
> +
> +	/* ARM mode */
> +	if (!(regs->pstate & PSR_AA32_T_BIT) ||
> +	    !(regs->pstate & PSR_AA32_IT_MASK))
> +		return;
> +
> +	it  = compat_get_it_state(regs);
> +
> +	/*
> +	 * If this is the last instruction of the block, wipe the IT
> +	 * state. Otherwise advance it.
> +	 */
> +	if (!(it & 7))
> +		it = 0;
> +	else
> +		it = (it & 0xe0) | ((it << 1) & 0x1f);
> +
> +	compat_set_it_state(regs, it);
> +}
>  
>  void arm64_skip_faulting_instruction(struct pt_regs *regs, unsigned long size)
>  {
> @@ -285,7 +333,7 @@ void arm64_skip_faulting_instruction(struct pt_regs *regs, unsigned long size)
>  	if (user_mode(regs))
>  		user_fastforward_single_step(current);
>  
> -	if (regs->pstate & PSR_MODE32_BIT)
> +	if (compat_user_mode(regs))
>  		advance_itstate(regs);
>  }
>  
> @@ -578,34 +626,6 @@ static const struct sys64_hook sys64_hooks[] = {
>  	{},
>  };
>  
> -
> -#ifdef CONFIG_COMPAT
> -#define PSTATE_IT_1_0_SHIFT	25
> -#define PSTATE_IT_1_0_MASK	(0x3 << PSTATE_IT_1_0_SHIFT)
> -#define PSTATE_IT_7_2_SHIFT	10
> -#define PSTATE_IT_7_2_MASK	(0x3f << PSTATE_IT_7_2_SHIFT)
> -
> -static u32 compat_get_it_state(struct pt_regs *regs)
> -{
> -	u32 it, pstate = regs->pstate;
> -
> -	it  = (pstate & PSTATE_IT_1_0_MASK) >> PSTATE_IT_1_0_SHIFT;
> -	it |= ((pstate & PSTATE_IT_7_2_MASK) >> PSTATE_IT_7_2_SHIFT) << 2;
> -
> -	return it;
> -}
> -
> -static void compat_set_it_state(struct pt_regs *regs, u32 it)
> -{
> -	u32 pstate_it;
> -
> -	pstate_it  = (it << PSTATE_IT_1_0_SHIFT) & PSTATE_IT_1_0_MASK;
> -	pstate_it |= ((it >> 2) << PSTATE_IT_7_2_SHIFT) & PSTATE_IT_7_2_MASK;
> -
> -	regs->pstate &= ~PSR_AA32_IT_MASK;
> -	regs->pstate |= pstate_it;
> -}
> -
>  static bool cp15_cond_valid(unsigned int esr, struct pt_regs *regs)
>  {
>  	int cond;
> @@ -626,29 +646,6 @@ static bool cp15_cond_valid(unsigned int esr, struct pt_regs *regs)
>  	return aarch32_opcode_cond_checks[cond](regs->pstate);
>  }
>  
> -static void advance_itstate(struct pt_regs *regs)
> -{
> -	u32 it;
> -
> -	/* ARM mode */
> -	if (!(regs->pstate & PSR_AA32_T_BIT) ||
> -	    !(regs->pstate & PSR_AA32_IT_MASK))
> -		return;
> -
> -	it  = compat_get_it_state(regs);
> -
> -	/*
> -	 * If this is the last instruction of the block, wipe the IT
> -	 * state. Otherwise advance it.
> -	 */
> -	if (!(it & 7))
> -		it = 0;
> -	else
> -		it = (it & 0xe0) | ((it << 1) & 0x1f);
> -
> -	compat_set_it_state(regs, it);
> -}
> -
>  static void compat_cntfrq_read_handler(unsigned int esr, struct pt_regs *regs)
>  {
>  	int reg = (esr & ESR_ELx_CP15_32_ISS_RT_MASK) >> ESR_ELx_CP15_32_ISS_RT_SHIFT;
> -- 
> 2.20.1
> 

-- 
Kees Cook
