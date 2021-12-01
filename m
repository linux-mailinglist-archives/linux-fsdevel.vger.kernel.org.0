Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C517465724
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Dec 2021 21:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244668AbhLAUcq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Dec 2021 15:32:46 -0500
Received: from foss.arm.com ([217.140.110.172]:46690 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239617AbhLAUcg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Dec 2021 15:32:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCA9013D5;
        Wed,  1 Dec 2021 12:29:14 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.65.205])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFC133F5A1;
        Wed,  1 Dec 2021 12:29:12 -0800 (PST)
Date:   Wed, 1 Dec 2021 20:29:06 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 3/4] arm64: Add support for user sub-page fault probing
Message-ID: <YafbEpoiFB4emaPW@FVFF77S0Q05N>
References: <20211201193750.2097885-1-catalin.marinas@arm.com>
 <20211201193750.2097885-4-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201193750.2097885-4-catalin.marinas@arm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Catalin,

On Wed, Dec 01, 2021 at 07:37:49PM +0000, Catalin Marinas wrote:
> With MTE, even if the pte allows an access, a mismatched tag somewhere
> within a page can still cause a fault. Select ARCH_HAS_SUBPAGE_FAULTS if
> MTE is enabled and implement the probe_subpage_*() functions. Note that
> get_user() is sufficient for the writeable checks since the same tag
> mismatch fault would be triggered by a read.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/Kconfig               |  1 +
>  arch/arm64/include/asm/uaccess.h | 59 ++++++++++++++++++++++++++++++++
>  2 files changed, 60 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index c4207cf9bb17..dff89fd0d817 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1777,6 +1777,7 @@ config ARM64_MTE
>  	depends on AS_HAS_LSE_ATOMICS
>  	# Required for tag checking in the uaccess routines
>  	depends on ARM64_PAN
> +	select ARCH_HAS_SUBPAGE_FAULTS
>  	select ARCH_USES_HIGH_VMA_FLAGS
>  	help
>  	  Memory Tagging (part of the ARMv8.5 Extensions) provides
> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> index 6e2e0b7031ab..bcbd24b97917 100644
> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -445,4 +445,63 @@ static inline int __copy_from_user_flushcache(void *dst, const void __user *src,
>  }
>  #endif
>  
> +#ifdef CONFIG_ARCH_HAS_SUBPAGE_FAULTS
> +
> +/*
> + * Return 0 on success, the number of bytes not accessed otherwise.
> + */
> +static inline size_t __mte_probe_user_range(const char __user *uaddr,
> +					    size_t size, bool skip_first)
> +{
> +	const char __user *end = uaddr + size;
> +	int err = 0;
> +	char val;
> +
> +	uaddr = PTR_ALIGN_DOWN(uaddr, MTE_GRANULE_SIZE);
> +	if (skip_first)
> +		uaddr += MTE_GRANULE_SIZE;

Do we need the skipping for a functional reason, or is that an optimization?

From the comments in probe_subpage_writeable() and
probe_subpage_safe_writeable() I wasn't sure if the skipping was because we
*don't need to* check the first granule, or because we *must not* check the
first granule.

> +	while (uaddr < end) {
> +		/*
> +		 * A read is sufficient for MTE, the caller should have probed
> +		 * for the pte write permission if required.
> +		 */
> +		__raw_get_user(val, uaddr, err);
> +		if (err)
> +			return end - uaddr;
> +		uaddr += MTE_GRANULE_SIZE;
> +	}

I think we may need to account for the residue from PTR_ALIGN_DOWN(), or we can
report more bytes not copied than was passed in `size` in the first place,
which I think might confused some callers.

Consider MTE_GRANULE_SIZE is 16, uaddr is 31, and size is 1 (so end is 32). We
align uaddr down to 16, and if we fail the first access we return (32 - 16),
i.e. 16.

Thanks,
Mark.

> +	(void)val;
> +
> +	return 0;
> +}
> +
> +static inline size_t probe_subpage_writeable(const void __user *uaddr,
> +					     size_t size)
> +{
> +	if (!system_supports_mte())
> +		return 0;
> +	/* first put_user() done in the caller */
> +	return __mte_probe_user_range(uaddr, size, true);
> +}
> +
> +static inline size_t probe_subpage_safe_writeable(const void __user *uaddr,
> +						  size_t size)
> +{
> +	if (!system_supports_mte())
> +		return 0;
> +	/* the caller used GUP, don't skip the first granule */
> +	return __mte_probe_user_range(uaddr, size, false);
> +}
> +
> +static inline size_t probe_subpage_readable(const void __user *uaddr,
> +					    size_t size)
> +{
> +	if (!system_supports_mte())
> +		return 0;
> +	/* first get_user() done in the caller */
> +	return __mte_probe_user_range(uaddr, size, true);
> +}
> +
> +#endif /* CONFIG_ARCH_HAS_SUBPAGE_FAULTS */
> +
>  #endif /* __ASM_UACCESS_H */
