Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8236418592C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Mar 2020 03:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgCOChC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Mar 2020 22:37:02 -0400
Received: from foss.arm.com ([217.140.110.172]:54432 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726712AbgCOChB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:37:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C24501FB;
        Sat, 14 Mar 2020 04:18:29 -0700 (PDT)
Received: from mbp (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61D1B3F67D;
        Sat, 14 Mar 2020 04:18:26 -0700 (PDT)
Date:   Sat, 14 Mar 2020 11:18:23 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
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
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Weimer <fweimer@redhat.com>,
        Sudakshina Das <sudi.das@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v9 08/13] arm64: traps: Shuffle code to eliminate forward
 declarations
Message-ID: <20200314111823.GA21082@mbp>
References: <20200311192608.40095-1-broonie@kernel.org>
 <20200311192608.40095-9-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311192608.40095-9-broonie@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 11, 2020 at 07:26:03PM +0000, Mark Brown wrote:
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

[...]

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

This patch breaks the kernel build with CONFIG_COMPAT disabled (e.g. 64K
page configuration) as sys64_hooks[] ends up in the #ifdef/#endif block.

-- 
Catalin
