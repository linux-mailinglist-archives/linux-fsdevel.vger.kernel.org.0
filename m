Return-Path: <linux-fsdevel+bounces-26806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3DA95BB7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 18:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87398B22A62
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 16:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4F61CDA30;
	Thu, 22 Aug 2024 16:12:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865241CDA08;
	Thu, 22 Aug 2024 16:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724343159; cv=none; b=rBAFsucXbSQo+GNqrGXDl5lYGSK+u2TdPXXlh3HGj8EQwXZNvoJeFWvYd1HWOVSQENIp6bFg8ZjMFukFJ0bNVFdHUCsNQY/ZUnltwlxfFiZXtdzNpFgyeP/X37pp/on+goxIzbw3VMKscnrWKpZsRI7KYpLUBcGbjNA5COS3ays=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724343159; c=relaxed/simple;
	bh=arNvsRUXm7jY00uvGkAwSitSYm9UxPvScMuijKZi0Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5e2AsFFZQJTuID5ka9rGZrp7RiQO8LfhXnbZ3Bo6xmclRchzH0THPvqxNSImvWAs9At1v+UlPtDCjF8od0qi2seVRAkqJtYbKLqAfke5aYyo/HgoRTZ/pLIE4W6x6s4JfxHqE1iHpzYkQphgiMajeE5PGEg8JvEEJ2CBI+v6og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A751C4AF0C;
	Thu, 22 Aug 2024 16:12:33 +0000 (UTC)
Date: Thu, 22 Aug 2024 17:12:30 +0100
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
Subject: Re: [PATCH v11 19/39] arm64/mm: Handle GCS data aborts
Message-ID: <ZsdjbsDrMWgBU9Hj@arm.com>
References: <20240822-arm64-gcs-v11-0-41b81947ecb5@kernel.org>
 <20240822-arm64-gcs-v11-19-41b81947ecb5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822-arm64-gcs-v11-19-41b81947ecb5@kernel.org>

On Thu, Aug 22, 2024 at 02:15:22AM +0100, Mark Brown wrote:
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 451ba7cbd5ad..3ada31c2ac12 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -486,6 +486,14 @@ static void do_bad_area(unsigned long far, unsigned long esr,
>  	}
>  }
>  
> +static bool is_gcs_fault(unsigned long esr)
> +{
> +	if (!esr_is_data_abort(esr))
> +		return false;
> +
> +	return ESR_ELx_ISS2(esr) & ESR_ELx_GCS;
> +}
> +
>  static bool is_el0_instruction_abort(unsigned long esr)
>  {
>  	return ESR_ELx_EC(esr) == ESR_ELx_EC_IABT_LOW;
> @@ -500,6 +508,23 @@ static bool is_write_abort(unsigned long esr)
>  	return (esr & ESR_ELx_WNR) && !(esr & ESR_ELx_CM);
>  }
>  
> +static bool is_invalid_gcs_access(struct vm_area_struct *vma, u64 esr)
> +{
> +	if (!system_supports_gcs())
> +		return false;
> +
> +	if (unlikely(is_gcs_fault(esr))) {
> +		/* GCS accesses must be performed on a GCS page */
> +		if (!(vma->vm_flags & VM_SHADOW_STACK))
> +			return true;

This first check covers the GCSPOPM/RET etc. permission faults on
non-GCS vmas. It looks correct.

> +	} else if (unlikely(vma->vm_flags & VM_SHADOW_STACK)) {
> +		/* Only GCS operations can write to a GCS page */
> +		return is_write_abort(esr);
> +	}

I don't think that's right. The ESR on this path may not even indicate a
data abort and ESR.WnR bit check wouldn't make sense.

I presume we want to avoid an infinite loop on a (writeable) GCS page
when the user does a normal STR but the CPU raises a permission fault. I
think this function needs to just return false if !esr_is_data_abort().

> +
> +	return false;
> +}
> +
>  static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>  				   struct pt_regs *regs)
>  {
> @@ -535,6 +560,14 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>  		/* It was exec fault */
>  		vm_flags = VM_EXEC;
>  		mm_flags |= FAULT_FLAG_INSTRUCTION;
> +	} else if (is_gcs_fault(esr)) {
> +		/*
> +		 * The GCS permission on a page implies both read and
> +		 * write so always handle any GCS fault as a write fault,
> +		 * we need to trigger CoW even for GCS reads.
> +		 */
> +		vm_flags = VM_WRITE;
> +		mm_flags |= FAULT_FLAG_WRITE;
>  	} else if (is_write_abort(esr)) {
>  		/* It was write fault */
>  		vm_flags = VM_WRITE;
> @@ -568,6 +601,13 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>  	if (!vma)
>  		goto lock_mmap;
>  
> +	if (is_invalid_gcs_access(vma, esr)) {
> +		vma_end_read(vma);
> +		fault = 0;
> +		si_code = SEGV_ACCERR;
> +		goto bad_area;
> +	}

Here there's a risk that the above function returns true for some
unrelated fault that happens to have bit 6 in ESR set.

-- 
Catalin

