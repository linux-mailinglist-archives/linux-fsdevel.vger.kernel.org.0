Return-Path: <linux-fsdevel+bounces-26243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A87195666E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 11:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1725B21B2E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 09:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAA315D5D8;
	Mon, 19 Aug 2024 09:10:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E08C15B99D;
	Mon, 19 Aug 2024 09:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724058644; cv=none; b=J7Zic+LsEbPmm7XPHSgnZVUJli8qR6JJ2AGJLUHTAnXAageopD5yp/M7yEdwmi+qGDEZ6ndmj72FWLrRDoFJiaDVeI5pPoFk9M2VVBICqH+mNnNcQvxjNPkkUyQ9hnskWweWeCxgfdSklCsbc3hixiDyTts4xkbRnrUhGUGqbiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724058644; c=relaxed/simple;
	bh=BmB/x9tpD9djunLeVJ0ZMwyZ9tQl8tu1tTkL3WWj89w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=am1QfZdZx8tfuRwMaiPawo8QHfdsycdzwtoL1Orl6FhHoq1ntvp1hC/RaomN8EfqREFYEvp85ZaeDnWc0nn9N60kdASvtZzRr+Da0lEE+1jR2V2FHJup8XTUU7M1hG6XlbAZ0Q37+yyBimIln4sJsljO0YRlAgMeU2SIQWZEv84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A672CC4AF0C;
	Mon, 19 Aug 2024 09:10:38 +0000 (UTC)
Date: Mon, 19 Aug 2024 10:10:36 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Shuah Khan <shuah@kernel.org>,
	"Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Kees Cook <kees@kernel.org>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Florian Weimer <fweimer@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	Ross Burton <ross.burton@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v10 13/40] arm64/mm: Map pages for guarded control stack
Message-ID: <ZsMMDNIp6Pkfbg1e@arm.com>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-13-699e2bd2190b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801-arm64-gcs-v10-13-699e2bd2190b@kernel.org>
X-TUID: BxqZX8z1MsWO

On Thu, Aug 01, 2024 at 01:06:40PM +0100, Mark Brown wrote:
> Map pages flagged as being part of a GCS as such rather than using the
> full set of generic VM flags.
> 
> This is done using a conditional rather than extending the size of
> protection_map since that would make for a very sparse array.
> 
> Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/include/asm/mman.h |  9 +++++++++
>  arch/arm64/mm/mmap.c          | 10 +++++++++-
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
> index c21849ffdd88..6d3fe6433a62 100644
> --- a/arch/arm64/include/asm/mman.h
> +++ b/arch/arm64/include/asm/mman.h
> @@ -61,6 +61,15 @@ static inline bool arch_validate_flags(unsigned long vm_flags)
>  			return false;
>  	}
>  
> +	if (system_supports_gcs() && (vm_flags & VM_SHADOW_STACK)) {
> +		/*
> +		 * An executable GCS isn't a good idea, and the mm
> +		 * core can't cope with a shared GCS.
> +		 */
> +		if (vm_flags & (VM_EXEC | VM_ARM64_BTI | VM_SHARED))
> +			return false;
> +	}

I wonder whether we should clear VM_MAYEXEC early on during the vma
creation. This way the mprotect() case will be handled in the core code.
At a quick look, do_mmap() seems to always set VM_MAYEXEC but discard it
for non-executable file mmap. Last time I looked (when doing MTE) there
wasn't a way for the arch code to clear specific VM_* flags, only to
validate them. But I think we should just clear VM_MAYEXEC and also
return an error for VM_EXEC in the core do_mmap() if VM_SHADOW_STACK. It
would cover the other architectures doing shadow stacks.

Regarding VM_SHARED, how do we even end up with this via the
map_shadow_stack() syscall? I can't see how one can pass MAP_SHARED to
do_mmap() on this path. I'm fine with a VM_WARN_ON() if you want the
check (and there's no way a user can trigger it).

Is there any arch restriction with setting BTI and GCS? It doesn't make
sense but curious if it matters. We block the exec permission anyway
(unless the BTI pages moved to PIE as well, I don't remember).

> +
>  	return true;
>  
>  }
> diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
> index 642bdf908b22..3ed63fc8cd0a 100644
> --- a/arch/arm64/mm/mmap.c
> +++ b/arch/arm64/mm/mmap.c
> @@ -83,9 +83,17 @@ arch_initcall(adjust_protection_map);
>  
>  pgprot_t vm_get_page_prot(unsigned long vm_flags)
>  {
> -	pteval_t prot = pgprot_val(protection_map[vm_flags &
> +	pteval_t prot;
> +
> +	/* Short circuit GCS to avoid bloating the table. */
> +	if (system_supports_gcs() && (vm_flags & VM_SHADOW_STACK)) {
> +		prot = _PAGE_GCS_RO;
> +	} else {
> +		prot = pgprot_val(protection_map[vm_flags &
>  				   (VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]);
> +	}

This looks fine to me. Such page will become proper GCS on first access.

-- 
Catalin

