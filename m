Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B944E181DE1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Mar 2020 17:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbgCKQbJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Mar 2020 12:31:09 -0400
Received: from foss.arm.com ([217.140.110.172]:51686 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730052AbgCKQbJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:31:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E968E31B;
        Wed, 11 Mar 2020 09:31:08 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8A643F6CF;
        Wed, 11 Mar 2020 09:31:05 -0700 (PDT)
Date:   Wed, 11 Mar 2020 16:31:03 +0000
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
Subject: Re: [PATCH v8 03/11] arm64: Basic Branch Target Identification
 support
Message-ID: <20200311163103.GL3216816@arrakis.emea.arm.com>
References: <20200227174417.23722-1-broonie@kernel.org>
 <20200227174417.23722-4-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227174417.23722-4-broonie@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 27, 2020 at 05:44:09PM +0000, Mark Brown wrote:
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 0b30e884e088..e37f4f07b990 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1519,6 +1519,28 @@ endmenu
>  
>  menu "ARMv8.5 architectural features"
>  
> +config ARM64_BTI
> +	bool "Branch Target Identification support"
> +	default y
> +	help
> +	  Branch Target Identification (part of the ARMv8.5 Extensions)
> +	  provides a mechanism to limit the set of locations to which computed
> +	  branch instructions such as BR or BLR can jump.
> +
> +	  To make use of BTI on CPUs that support it, say Y.
> +
> +	  BTI is intended to provide complementary protection to other control
> +	  flow integrity protection mechanisms, such as the Pointer
> +	  authentication mechanism provided as part of the ARMv8.3 Extensions.
> +	  For this reason, it does not make sense to enable this option without
> +	  also enabling support for pointer authentication.  Thus, when
> +	  enabling this option you should also select ARM64_PTR_AUTH=y.
> +
> +	  Userspace binaries must also be specifically compiled to make use of
> +	  this mechanism.  If you say N here or the hardware does not support
> +	  BTI, such binaries can still run, but you get no additional
> +	  enforcement of branch destinations.

To keep the series bisectable, I'd move the Kconfig into a separate
patch towards the end. It looks like the feature is only partially
supported after patch 3, so let's not advertise it here.

-- 
Catalin
