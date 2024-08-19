Return-Path: <linux-fsdevel+bounces-26247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 241D89566B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 11:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4995A1C21539
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 09:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC4C15F3EA;
	Mon, 19 Aug 2024 09:18:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0A615C125;
	Mon, 19 Aug 2024 09:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724059080; cv=none; b=Hk0EjWXbYBQNwn7Yx9PU6Pls5eQgtoyuvqKOgRzF+yCp1TpD8MYscJFwTQgzogy0UQVHhIRJVieGKnGpzhROZH/PtmeP5MxtDjsu56svqr3ZrDHZQYo7ijKk95SGGCQhkY1x81nWPuB8ornN5xtDfEDN2axVN3lb9ek84MI6EI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724059080; c=relaxed/simple;
	bh=5yco6AZzuk6zXWLnLgO+GLuPg9ixHRuWqqCX+fQvexk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2t1riG4mRRQBYi/8oD8fd1YRi+8Z3qqhKeGLleA0IIMz+YGjMDWpC72rUbR/Jsoe/U/Ob6GwN0dCXKVpocjxlCeDdl1XKsb8MoA8ywnomN6/aTjUjYgs7w0123J4WAa/9vOQLjhVV+l/8L6OlnapAQqFtoH0AN6j3EAEAN031Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8FCC32782;
	Mon, 19 Aug 2024 09:17:54 +0000 (UTC)
Date: Mon, 19 Aug 2024 10:17:52 +0100
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
Subject: Re: [PATCH v10 18/40] arm64/mm: Handle GCS data aborts
Message-ID: <ZsMNwAsAWr2IxFns@arm.com>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-18-699e2bd2190b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801-arm64-gcs-v10-18-699e2bd2190b@kernel.org>
X-TUID: ycLXmrxDHVW6

On Thu, Aug 01, 2024 at 01:06:45PM +0100, Mark Brown wrote:
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 451ba7cbd5ad..0973dd09f11a 100644
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
> @@ -500,6 +508,25 @@ static bool is_write_abort(unsigned long esr)
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
> +		if (!(vma->vm_flags & VM_WRITE))
> +			return true;

Do we need the VM_WRITE check here? Further down in do_page_fault(), we
already do the check as we set vm_flags = VM_WRITE.

> +	} else if (unlikely(vma->vm_flags & VM_SHADOW_STACK)) {
> +		/* Only GCS operations can write to a GCS page */
> +		return is_write_abort(esr);
> +	}
> +
> +	return false;
> +}
> +
>  static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>  				   struct pt_regs *regs)
>  {
> @@ -535,6 +562,14 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
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
> @@ -568,6 +603,13 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>  	if (!vma)
>  		goto lock_mmap;
>  
> +	if (is_invalid_gcs_access(vma, esr)) {
> +		vma_end_read(vma);
> +		fault = 0;
> +		si_code = SEGV_ACCERR;
> +		goto bad_area;
> +	}
> +
>  	if (!(vma->vm_flags & vm_flags)) {
>  		vma_end_read(vma);
>  		fault = 0;

This check I mentioned above.

I was wondering whether we should prevent mprotect(PROT_READ) on the GCS
page. But I guess that's fine, we'll SIGSEGV later if we get an invalid
GCS access.

-- 
Catalin

