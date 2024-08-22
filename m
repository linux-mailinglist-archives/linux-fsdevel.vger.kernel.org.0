Return-Path: <linux-fsdevel+bounces-26707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF0695B2C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 12:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CCCB283651
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 10:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991D517E91A;
	Thu, 22 Aug 2024 10:19:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2594E14F9DA;
	Thu, 22 Aug 2024 10:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724321999; cv=none; b=l2YRJ95h3hknl/aJqDCA2EhBlIJ9bw4MY9qyB13uPCVCCMfFcAf0IY35PS4rPq6UW2J1Ld+RYvw5iOY3ZOjTKm5fU1HPlnGE6YYJ8LUTjSTJ4IJ5xNtS9fix6fgT24khryNaFmOIHN5GLE0VPshstDwEiJrok1M25GI5GYUk0zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724321999; c=relaxed/simple;
	bh=EKZr39InrxJs348PMtmf9ETHw+B/7T2Vh8xHcpRmmoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJZSsnJ3imtC3alLBS6o1YozqRtyUrPTf6wnmua0z6lN/VOmmqFu2EBK68UL8CUm2UXiBto6OdhzO0AqSWDHJ/kukZjpWUDPEft9rlx59KlIhE6gnmg1e3/NMaopZZXoQrrc7+D1icKc4WpqSblmH7b7+abtFJ4TCw+/NAcDcro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBE0C32782;
	Thu, 22 Aug 2024 10:19:52 +0000 (UTC)
Date: Thu, 22 Aug 2024 11:19:50 +0100
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
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v11 14/39] arm64/mm: Map pages for guarded control stack
Message-ID: <ZscQxkigY0uNM6Xc@arm.com>
References: <20240822-arm64-gcs-v11-0-41b81947ecb5@kernel.org>
 <20240822-arm64-gcs-v11-14-41b81947ecb5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822-arm64-gcs-v11-14-41b81947ecb5@kernel.org>

On Thu, Aug 22, 2024 at 02:15:17AM +0100, Mark Brown wrote:
> diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
> index c21849ffdd88..37dfd2882f04 100644
> --- a/arch/arm64/include/asm/mman.h
> +++ b/arch/arm64/include/asm/mman.h
> @@ -61,6 +61,15 @@ static inline bool arch_validate_flags(unsigned long vm_flags)
>  			return false;
>  	}
>  
> +	if (system_supports_gcs() && (vm_flags & VM_SHADOW_STACK)) {
> +		/* An executable GCS isn't a good idea. */
> +		if (vm_flags & VM_EXEC)
> +			return false;

Later we should look at clear VM_MAYEXEC in the core code (if the x86
folk agree).

> +
> +		/* The memory management core should prevent this */
> +		VM_WARN_ON(vm_flags & VM_SHARED);
> +	}
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
>  
> +	/* VM_ARM64_BTI on a GCS is rejected in arch_validate_flags() */

Not anymore.

>  	if (vm_flags & VM_ARM64_BTI)
>  		prot |= PTE_GP;

Other than the comment above, it looks good.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

