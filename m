Return-Path: <linux-fsdevel+bounces-28432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C79996A2B7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 17:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FB001C21F90
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 15:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B16D189F20;
	Tue,  3 Sep 2024 15:29:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA1B189533;
	Tue,  3 Sep 2024 15:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725377388; cv=none; b=HG7q3bbY1okcabYpnPm+fk3fmG+NPKhmMHU2DlYaj+jjllNYfVBkwq/Gbwwfrj7gY5MHTHXzx3wAUtkzZRcePFr/p/GLlYGrOLMpws6qV09yb8La2PN3nC4c0YYTACZB1OVAyZDYFzr2jbGSxbmAo1No7oq/X1bANuCS7dlBdws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725377388; c=relaxed/simple;
	bh=0h/zNY8bJ/TNcS1t7SeY1xaa/nugscrq+MyZ7fVrr3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHiyMXYi1LNpmRULSE5xTXhABqC5fc3eCSH7qgXvASOUcdUWdqi+p5gCxdpTFuYhrdBfsr1SDVjUnw2jTooOrVleiYbLQbg+h2SLPBaWms/5SrfNXHlMrv5Jwut3b0Vj9FuJ0mU4cVcXxYox9i3jxiZPtYHs3rrb8wL0tIejHGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46809FEC;
	Tue,  3 Sep 2024 08:30:12 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 841EB3F66E;
	Tue,  3 Sep 2024 08:29:42 -0700 (PDT)
Date: Tue, 3 Sep 2024 16:29:37 +0100
From: Joey Gouly <joey.gouly@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, nd@arm.com,
	akpm@linux-foundation.org, aneesh.kumar@kernel.org,
	aneesh.kumar@linux.ibm.com, anshuman.khandual@arm.com, bp@alien8.de,
	catalin.marinas@arm.com, christophe.leroy@csgroup.eu,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, skhan@linuxfoundation.org,
	szabolcs.nagy@arm.com, tglx@linutronix.de, will@kernel.org,
	x86@kernel.org, kvmarm@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 16/30] arm64: handle PKEY/POE faults
Message-ID: <20240903152937.GA3768522@e124191.cambridge.arm.com>
References: <20240822151113.1479789-1-joey.gouly@arm.com>
 <20240822151113.1479789-17-joey.gouly@arm.com>
 <40600b75-68eb-421a-a122-256bd20afb89@sirena.org.uk>
 <20240903144823.GA3669886@e124191.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903144823.GA3669886@e124191.cambridge.arm.com>

On Tue, Sep 03, 2024 at 03:50:46PM +0100, Joey Gouly wrote:
> On Thu, Aug 29, 2024 at 06:55:07PM +0100, Mark Brown wrote:
> > On Thu, Aug 22, 2024 at 04:10:59PM +0100, Joey Gouly wrote:
> > 
> > > +static bool fault_from_pkey(unsigned long esr, struct vm_area_struct *vma,
> > > +			unsigned int mm_flags)
> > > +{
> > > +	unsigned long iss2 = ESR_ELx_ISS2(esr);
> > > +
> > > +	if (!system_supports_poe())
> > > +		return false;
> > > +
> > > +	if (iss2 & ESR_ELx_Overlay)
> > > +		return true;
> > 
> > Does this need an is_data_abort() && is_instruction_abort() check?
> > Overlay doesn't appear to be defined for all exception types and it
> > wasn't clear enough to me that the callers have done this check.
> 
> The only callers are in do_page_fault(), which should only be data or
> instruction aborts. I talked with Catalin and he said it's fine to not check
> again here.
> 
> I can add a permissions check though:
> 
> commit 033270f5a9462e998b4dee11fc91b43ac7929756
> Author: Joey Gouly <joey.gouly@arm.com>
> Date:   Tue Sep 3 15:45:59 2024 +0100
> 
>     fixup! arm64: handle PKEY/POE faults
> 
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index a68055150950..f651553a8ab8 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -495,6 +495,9 @@ static bool fault_from_pkey(unsigned long esr, struct vm_area_struct *vma,
>         if (!system_supports_poe())
>                 return false;
>  
> +       if (!esr_fsc_is_permission_fault(esr))
> +               return false;
> +
>         if (iss2 & ESR_ELx_Overlay)
>                 return true;
>  
> 
> 
> Since the ESR_EL1 documentation says:
> 	If a memory access generates a Data Abort for a Permission fault, then this field holds information
> 	about the fault.
> 

Sorry, I was a bit too eager with that patch.  The previous patch was bailing
out before the vma-backed checks could take place.

It should be:

commit 7b67b149f2f492e907b27521c95639f4ea208221 (HEAD -> permission_overlay_v6)
Author: Joey Gouly <joey.gouly@arm.com>
Date:   Tue Sep 3 15:45:59 2024 +0100

    fixup! arm64: handle PKEY/POE faults

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index a68055150950..8b281cf308b3 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -495,7 +495,7 @@ static bool fault_from_pkey(unsigned long esr, struct vm_area_struct *vma,
        if (!system_supports_poe())
                return false;
 
-       if (iss2 & ESR_ELx_Overlay)
+       if (esr_fsc_is_permission_fault(esr) && (iss2 & ESR_ELx_Overlay))
                return true;
 
        return !arch_vma_access_permitted(vma,

