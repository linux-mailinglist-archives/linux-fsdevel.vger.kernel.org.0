Return-Path: <linux-fsdevel+bounces-26125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CFB954C25
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 16:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 617B4281765
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 14:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E981D1BCA1C;
	Fri, 16 Aug 2024 14:17:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EFA156967;
	Fri, 16 Aug 2024 14:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723817825; cv=none; b=Bp6vDaQuNcTAgrWnXiqKGIDY9MAPHwVw/VVJTLGMeZ30zawDlNT+ACYX1Uv15J6mz0gKOZgpRazrrJWPWcUlRfjBbLdkvVmQQlDAtQSDtMz1E0AWYhZBFMBbcNyKid20XWyLHSpaKE+WQiRHsCJ47W2eotCBdoujiIT824pkgl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723817825; c=relaxed/simple;
	bh=opkN6ZS9Pvj4MDCFP9lC8HtXMGO+HgUQLEsFJbfmIF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VytnRPGCFSFu/dgtFIDx0gmRCo9f7Cj63kVpJtdlZgPWf4hr6cCYVapdDjM2+XBgEF5p9Mi8Lp/HeJcK0MxfGNQakt+r0fyVNs0LoaDilZXvwaffhSLB2A/rrue3FhPPhedO/ijMP33QBGf4K3ZbvPdI9j4g6NLLG2Ylh9UGFeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A30C32782;
	Fri, 16 Aug 2024 14:16:59 +0000 (UTC)
Date: Fri, 16 Aug 2024 15:16:57 +0100
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
Subject: Re: [PATCH v10 11/40] arm64/mm: Allocate PIE slots for EL0 guarded
 control stack
Message-ID: <Zr9fWfRObI5TNNXg@arm.com>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-11-699e2bd2190b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801-arm64-gcs-v10-11-699e2bd2190b@kernel.org>

On Thu, Aug 01, 2024 at 01:06:38PM +0100, Mark Brown wrote:
> diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
> index b11cfb9fdd37..545d54c88520 100644
> --- a/arch/arm64/include/asm/pgtable-prot.h
> +++ b/arch/arm64/include/asm/pgtable-prot.h
> @@ -144,15 +144,23 @@ static inline bool __pure lpa2_is_enabled(void)
>  /* 6:                                PTE_PXN | PTE_WRITE            */
>  /* 7: PAGE_SHARED_EXEC               PTE_PXN | PTE_WRITE | PTE_USER */
>  /* 8: PAGE_KERNEL_ROX      PTE_UXN                                  */
> -/* 9:                      PTE_UXN |                       PTE_USER */
> +/* 9: PAGE_GCS_RO          PTE_UXN |                       PTE_USER */
>  /* a: PAGE_KERNEL_EXEC     PTE_UXN |           PTE_WRITE            */
> -/* b:                      PTE_UXN |           PTE_WRITE | PTE_USER */
> +/* b: PAGE_GCS             PTE_UXN |           PTE_WRITE | PTE_USER */
>  /* c: PAGE_KERNEL_RO       PTE_UXN | PTE_PXN                        */
>  /* d: PAGE_READONLY        PTE_UXN | PTE_PXN |             PTE_USER */
>  /* e: PAGE_KERNEL          PTE_UXN | PTE_PXN | PTE_WRITE            */
>  /* f: PAGE_SHARED          PTE_UXN | PTE_PXN | PTE_WRITE | PTE_USER */
>  
> +#define _PAGE_GCS	(_PAGE_DEFAULT | PTE_NG | PTE_UXN | PTE_WRITE | PTE_USER)
> +#define _PAGE_GCS_RO	(_PAGE_DEFAULT | PTE_NG | PTE_UXN | PTE_USER)
> +
> +#define PAGE_GCS	__pgprot(_PAGE_GCS)
> +#define PAGE_GCS_RO	__pgprot(_PAGE_GCS_RO)
> +
>  #define PIE_E0	( \
> +	PIRx_ELx_PERM(pte_pi_index(_PAGE_GCS),           PIE_GCS)  | \
> +	PIRx_ELx_PERM(pte_pi_index(_PAGE_GCS_RO),        PIE_R)   | \
>  	PIRx_ELx_PERM(pte_pi_index(_PAGE_EXECONLY),      PIE_X_O) | \
>  	PIRx_ELx_PERM(pte_pi_index(_PAGE_READONLY_EXEC), PIE_RX)  | \
>  	PIRx_ELx_PERM(pte_pi_index(_PAGE_SHARED_EXEC),   PIE_RWX) | \
> @@ -160,6 +168,8 @@ static inline bool __pure lpa2_is_enabled(void)
>  	PIRx_ELx_PERM(pte_pi_index(_PAGE_SHARED),        PIE_RW))
>  
>  #define PIE_E1	( \
> +	PIRx_ELx_PERM(pte_pi_index(_PAGE_GCS),           PIE_NONE_O) | \
> +	PIRx_ELx_PERM(pte_pi_index(_PAGE_GCS_RO),        PIE_NONE_O) | \

It's fine to keep PIE_NONE_O here, the kernel wouldn't need to access
this memory with unprivileged instructions (it only matters for the
futex code using LDXR/STXR).

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

