Return-Path: <linux-fsdevel+bounces-22126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C23C912BF8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 18:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35C63286AE3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 16:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E44C160884;
	Fri, 21 Jun 2024 16:57:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34824364AB;
	Fri, 21 Jun 2024 16:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718989061; cv=none; b=LBiWEDjqfgNJTyvB6PoCE+C4htQUM0RDOfxqK1yX7K3TaonZOSFxcrU5BeyFocXC/ESOqsQlAVmTbMOVthtcP1BDpSae91Mql4vIo7AGuWLrEfo/XYwr8znh3X+uoXks/EB9iZjZV5t9zw4I8B/rHpDqEQ9abULscpj2zcaztec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718989061; c=relaxed/simple;
	bh=dXFuVjmaAK7ttxhTnAqFMgHts5oyZBbMIdM9CEh6rfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mw+az1PW+MWxDHcQxphH1LhagE2dnE5+RL/mwFxuOsjoSgjU63hpTqgtAivdga9lio8KSFPraUpi+SwLegOi8J1D0M4saGT1G4x3vaWbv4FvWbwYb/7AHXr6sgu0ynZAwGJJ7kb1dbkgMjch3z//FQsnae0x+DbpoG0emmXEljo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F90CC2BBFC;
	Fri, 21 Jun 2024 16:57:36 +0000 (UTC)
Date: Fri, 21 Jun 2024 17:57:34 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Joey Gouly <joey.gouly@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	aneesh.kumar@kernel.org, aneesh.kumar@linux.ibm.com, bp@alien8.de,
	broonie@kernel.org, christophe.leroy@csgroup.eu,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, szabolcs.nagy@arm.com,
	tglx@linutronix.de, will@kernel.org, x86@kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 15/29] arm64: handle PKEY/POE faults
Message-ID: <ZnWw_tZZYgpOQVqf@arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-16-joey.gouly@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503130147.1154804-16-joey.gouly@arm.com>

On Fri, May 03, 2024 at 02:01:33PM +0100, Joey Gouly wrote:
> @@ -529,6 +547,8 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>  	unsigned int mm_flags = FAULT_FLAG_DEFAULT;
>  	unsigned long addr = untagged_addr(far);
>  	struct vm_area_struct *vma;
> +	bool pkey_fault = false;
> +	int pkey = -1;
>  
>  	if (kprobe_page_fault(regs, esr))
>  		return 0;
> @@ -590,6 +610,12 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>  		vma_end_read(vma);
>  		goto lock_mmap;
>  	}
> +
> +	if (fault_from_pkey(esr, vma, mm_flags)) {
> +		vma_end_read(vma);
> +		goto lock_mmap;
> +	}
> +
>  	fault = handle_mm_fault(vma, addr, mm_flags | FAULT_FLAG_VMA_LOCK, regs);
>  	if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
>  		vma_end_read(vma);
> @@ -617,6 +643,11 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>  		goto done;
>  	}
>  
> +	if (fault_from_pkey(esr, vma, mm_flags)) {
> +		pkey_fault = true;
> +		pkey = vma_pkey(vma);
> +	}

I was wondering if we actually need to test this again. We know the
fault was from a pkey already above but I guess it matches what we do
with the vma->vm_flags check in case it races with some mprotect() call.

> +
>  	fault = __do_page_fault(mm, vma, addr, mm_flags, vm_flags, regs);

You'll need to rebase this on 6.10-rcX since this function disappeared.

Otherwise the patch looks fine.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

